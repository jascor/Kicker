class UpdateArticlesAfterSectionUpdate
  include SuckerPunch::Job

  def perform(section)
    ActiveRecord::Base.connection_pool.with_connection do
      articles = Article.where(section_id: section)

      articles.each do |article|
        article.remove_stale_cache
      end
    end
  end
end