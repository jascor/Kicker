class Article < BaseModel
  include SanitizationHelper
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one :featured_media_collection, class_name: 'MediaCollection', primary_key: 'featured_media_id', foreign_key: 'id'

  has_one :featured_media, class_name: 'Medium', primary_key: 'featured_media_id', foreign_key: 'id'

  has_many :article_tags, dependent: :destroy
  has_many :section_page_section_contents, dependent: :destroy
  has_many :writers, class_name: 'WriterArticle', dependent: :destroy

  belongs_to :section
  belongs_to :subsection, class_name: 'Section', foreign_key: 'subsection_id'
  belongs_to :article_type
  belongs_to :submitter, class_name: 'User', primary_key: 'user_id'

  before_save :process_raw_contents

  after_save :make_slug_if_pubbed
  after_save :published_timestamp_if_pubbed
  after_save :create_summary_if_nil, if: :published?
  after_save :render_custom_sass_to_css
  after_save :update_formatted_writers_names, if: :published?

  after_save :remove_stale_cache, if: :published_and_public?

  after_destroy :remove_stale_cache

  validates :headline, :raw_contents, presence: true, if: :published?

  def self.find_with_assoc(id, slug = nil)
    if slug.nil?
      self.with_assoc.find(id)
    else
      self.with_assoc.where(id: id, slug: slug).take!
    end
  end

  def self.latest_with_assoc(limit, exclude = [], section = nil, override_key = nil)
    where_hash = {
        published: true,
        private: false
    }

    cache_key = 'latest'

    if section
      cache_key = (override_key || 'latestFor_') + section.to_s
      where_hash[:section_id] = section
    end

    Rails.cache.fetch([name, cache_key]) { self.with_assoc.order(published_at: :desc).where(where_hash).where.not(id: exclude).take(limit) }
  end

  def self.with_assoc
    self.includes(:section, { writers: :writer }, :featured_media, { featured_media_collection: { media_collection_contents: :medium } }, :article_type)
  end

  def self.find_cached(id)
    Rails.cache.fetch([name, id]) { includes(:section, { writers: :writer }, :featured_media, { featured_media_collection: { media_collection_contents: :medium } }, :article_type).where(id: id).take! }
  end

  def self.find_cached_by_slug(slug)
    Rails.cache.fetch([name, slug]) { includes(:section, { writers: :writer }, :featured_media, { featured_media_collection: { media_collection_contents: :medium } }, :article_type).find_by_slug!(slug) }
  end

  def self.get_most_important_published(from, limit, rewind_if_limit_not_reached, section = nil, override_key = nil)
    where_hash = {
        published: true,
        private: false
    }

    cache_key = 'mostImportantPublished'

    if section
      cache_key = (override_key || 'mostImportantPublishedFor_') + section.to_s

      where_hash[:section_id] = section
    end

    articles = Rails.cache.fetch([name, cache_key]) { self.with_assoc.order(importance: :desc).where(where_hash).where('published_at >= :time_ago', time_ago: from).take(limit) }

    # If the number of articles found is less than the limit, we go back one more month from the 'from' argument time, up to twelve months, until we reach the limit
    if rewind_if_limit_not_reached
      if articles.length < limit
        i = 1

        while articles.length < limit
          Rails.cache.delete([name, cache_key])

          from = from - i.month

          articles = Rails.cache.fetch([name, cache_key]) { self.with_assoc.order(importance: :desc).where(where_hash).where('published_at >= :time_ago', time_ago: from).take(limit) }

          i = i + 1

          if i > 12
            break
          end
        end
      end
    end

    articles
  end

  def published_and_public?
    published? && !private?
  end

  def has_featured_media?
    !self.featured_media_id.nil?
  end

  def get_featured_media
    if self.featured_media_is_collection?
      self.featured_media_collection.formatted_slide_props
    else
      self.featured_media
    end
  end

  def update_formatted_writers_names
    all_writers = WriterArticle.where(article_id: self.id)
    number_of_writers = all_writers.length

    return nil unless number_of_writers > 0

    if number_of_writers == 1
      update_columns(formatted_writers_names: writer_to_byline_html(all_writers[0].writer))

      remove_stale_cache

      return
    end

    number_of_writers_index = number_of_writers - 1

    formatted_writers = all_writers.map.with_index do |writer, index|
      (number_of_writers > 2 && index != 0 ? ', ' : '') +
          (index == number_of_writers_index ? ' and '  : '') +
          writer_to_byline_html(writer.writer)
    end

    update_columns(formatted_writers_names: formatted_writers.join(''))

    remove_stale_cache
  end

  def remove_stale_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, slug])
    Rails.cache.delete([self.class.name, 'latest'])
    Rails.cache.delete([self.class.name, 'latestFor_' + self.section.name]) if self.section
    Rails.cache.delete([self.class.name, 'mostImportantPublished'])
    Rails.cache.delete([self.class.name, 'mostImportantPublishedFor_' + self.section.name]) if self.section

    Fastly::purge_key(cache_key)
    Fastly::purge_key(self.section.cache_key) if self.section
  end

  def cache_key
    "#{self.class.name}/#{id}"
  end

  private

  def writer_to_byline_html(writer)
    '<a href="/author/' +
        writer.slug +
        '"><address class="author" itemprop="creator">' +
        writer.name +
        '</address></a>'
  end

  def render_custom_sass_to_css
    unless self.raw_sass.nil?
      begin
        css = Sass::Engine.new(self.raw_sass, syntax: :scss, style: :compressed).render
      rescue Sass::SyntaxError
        css = nil
      end

      unless css.nil?
        update_columns(custom_sass: css)
      end
    end
  end

  def create_summary_if_nil
    if summary.nil?
      html = Nokogiri::HTML(self.contents)
      first_paragraph = html.css('p').first.inner_html
      first_paragraph.gsub("\n", '').gsub("\t", '')
      first_paragraph.lstrip!
      first_paragraph.rstrip!

      if first_paragraph.length > 0
        update_columns(summary: first_paragraph)
      end
    end
  end

  def process_raw_contents
    if published?
      self.contents = ArticlePreprocess.new(self.raw_contents).execute
    end
  end

  def make_slug_if_pubbed
    if published_and_public? && slug.nil?
      create_slug = make_slug(headline)
      create_timestamp = created_at.strftime('%Y%m%d')
      make_slug = "#{create_slug}-#{self.id}-#{create_timestamp}-article.html"
      update_columns(slug: make_slug)
    end
  end

  def published_timestamp_if_pubbed
    if published_and_public? && published_at.nil?
      update_columns(published_at: Time.now)
    end
  end
end