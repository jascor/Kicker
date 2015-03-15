class Article < BaseModel
  include SanitizationHelper
  include Elasticsearch::Model

  has_one :featured_media, class_name: 'Medium', primary_key: 'featured_media_id', foreign_key: 'id'

  has_many :article_tags
  has_many :section_page_section_contents

  belongs_to :section
  belongs_to :subsection, class_name: 'Section', foreign_key: 'subsection_id'
  belongs_to :article_type
  belongs_to :writer_article
  belongs_to :submitter, class_name: 'User', primary_key: 'user_id'

  after_save :make_slug_if_pubbed
  after_save :published_timestamp_if_pubbed

  after_update :remove_stale_cache

  def self.find_cached(id)
    Rails.cache.fetch([name, id]) { includes(:article_type, :section, :subsection).find(id) }
  end

  def self.find_cached_by_slug(slug)
    Rails.cache.fetch([name, slug]) { includes(:article_type, :section, :subsection).find_by_slug!(slug) }
  end

  def published_and_public?
    published? && !private?
  end

private

  def make_slug_if_pubbed
    if published_and_public? && slug.nil?
      create_slug = make_slug(headline)
      create_timestamp = created_at.strftime('%Y%m%d')
      make_slug = "#{create_slug}-#{create_timestamp}-article.html"
      update_columns(slug: make_slug)
    end
  end

  def published_timestamp_if_pubbed
    if published_and_public? && published_at.nil?
      update_columns(published_at: Time.now)
    end
  end

  def remove_stale_cache
    # @todo Very "hacky" solution to this; build engine to handle config options and load from database on app init and reload on settings update
    if Kicker::Application.config.enable_redis_cache
      Rails.cache.delete([self.class.name, id])
      Rails.cache.delete([self.class.name, slug])
    end
  end
end