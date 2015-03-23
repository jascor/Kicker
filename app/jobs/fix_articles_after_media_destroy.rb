class FixArticlesAfterMediaDestroy
  include SuckerPunch::Job

  def perform(media_id)
    ActiveRecord::Base.connection_pool.with_connection do
      articles = Article.where(featured_media_id: media_id)

      articles.each do |article|
        article.update({ featured_media_id: nil, featured_media_is_collection: false })
      end
    end
  end
end