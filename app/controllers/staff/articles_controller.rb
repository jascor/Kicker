module Staff
  class ArticlesController < StaffController
    def index
      page = (params[:page] || 1).to_i

      per_page = (params[:per_page] || 15).to_i

      @articles = Article.includes(:section, :subsection, :article_type).page(page).per(per_page)

      #render json: @articles, meta: { total_pages: @articles.total_pages }, include: [:section, :subsection, :article_type]
      #@articles = Article.all.includes(:section, :subsection, :article_type)
    end

    def new

    end

    def create
      @article = Article.new article_params

      if @article.save
        if params[:tags]

        end

        render json: { article: @article }, status: 201
      else
        render json: @article.errors.full_messages
      end
    end

  private

    def article_params
      params.require(:article).permit(:featured_media_id, :article_type_id, :section_id, :subsection_id, :published, :private, :disable_comments, :raw_writer_name, :headline, :subheading, :summary, :raw_contents, :slug)
    end
  end
end