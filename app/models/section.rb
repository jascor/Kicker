class Section < BaseModel
  include SanitizationHelper
  #include Cacheable

  has_many :articles, dependent: :destroy
  has_many :section_page_sections, dependent: :destroy

  after_save :create_slug

  after_update :update_articles
  after_update :remove_stale_cache

  def self.get_all_with_article_assocs
    self.includes(articles: [{ writers: :writer }, :featured_media, { featured_media_collection: { media_collection_contents: :medium } }])
  end

  def self.all_cached
    Rails.cache.fetch([name, 'all']) { all }
  end

  def self.find_cached_by_slug(slug)
    Rails.cache.fetch([name, slug]) { find_by_slug!(slug) }
  end

  def remove_stale_cache
    Rails.cache.delete([self.class.name, slug])

    Fastly::purge_key(cache_key)
  end

  def cache_key
    "#{self.class.name}/#{id}"
  end

  private

  def create_slug
    update_attributes(slug: make_slug(name))
  end

  def update_articles
    UpdateArticlesAfterSectionUpdate.new.async.perform(self.id)
  end
end