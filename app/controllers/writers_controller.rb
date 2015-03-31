class WritersController < ApplicationController
  def show
    @data = {}

    @data[:sections] = Section.all

    @data[:writer] = Writer.where(slug: params[:author_slug]).take!

    @data[:current_page] = (params[:page] || 1).to_i

    @data[:paginated_articles] = WriterArticle.includes(article: [:section, { writers: :writer }, :featured_media, { featured_media_collection: { media_collection_contents: :medium } }]).order(published_at: :desc).where(writer_id: @data[:writer].id).where.not(published_at: nil).page(@data[:current_page]).per(15)

    section_ids_concat = @data[:sections].map(&:cache_key).join(' ')
    article_ids_concat = @data[:paginated_articles].map(&:cache_key).join(' ')

    response.headers['Surrogate-Key'] = "#{@data[:writer].cache_key} #{section_ids_concat} #{article_ids_concat}"

    #@data[:paginated_articles] = Article.with_assoc.where(writer_id: @data[:writer].id, published: true, private: false).page(@data[:current_page]).per(15)
  end
end