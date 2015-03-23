class Writer < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :writer_articles, dependent: :destroy

  after_update :update_articles
  after_update :remove_stale_cache

  def cache_key
    "#{self.class.name}/#{id}"
  end

  private

  def remove_stale_cache
    Fastly::purge_key(cache_key)
  end

  def update_articles
    UpdateArticleWritersNamesForWriter.new.async.perform(self.writer_articles)
  end
end
