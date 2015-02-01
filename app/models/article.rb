class Article < BaseModel
  include SanitizationHelper

  has_one :featured_image, class_name: 'Section', foreign_key: 'user_id'

  has_many :article_tags
  has_many :section_page_section_contents

  belongs_to :section
  belongs_to :subsection, class_name: 'Section'
  belongs_to :article_type

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
      update_columns(slug: "#{create_slug}-#{created_at.year}#{created_at.month}#{created_at.day}-article.html")
    end
  end

  def published_timestamp_if_pubbed
    if published_and_public? && published_at.nil?
      update_columns(published_at: Time.now)
    end
  end

  def remove_stale_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, slug])
  end
end