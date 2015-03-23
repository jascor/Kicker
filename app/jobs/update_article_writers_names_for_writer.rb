class UpdateArticleWritersNamesForWriter
  include SuckerPunch::Job

  def perform(writer_articles)
    writer_articles.each do |writer_article|
      ActiveRecord::Base.connection_pool.with_connection do
        writer_article.article.update_formatted_writers_names
      end
    end
  end
end