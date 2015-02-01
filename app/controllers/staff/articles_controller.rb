module Staff
  class ArticlesController < StaffController
    def index

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