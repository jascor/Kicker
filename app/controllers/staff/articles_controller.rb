module Staff
  class ArticlesController < StaffController
    before_action :authenticate_user!

    def index
      page = (params[:page] || 1).to_i

      per_page = (params[:per_page] || 15).to_i

      @articles = Article.includes({ writers: :writer }, :section, :article_type).order(created_at: :desc).page(page).per(per_page)
    end

    def show
      @article = Article.find params[:id]

      render 'single'
    end

    def create
      @article = Article.new article_params

      if @article.save
        if params[:article][:tags]
          params[:article][:tags].each do |tag|
            article_tag = tag.dup
            article_tag.lstrip!
            article_tag.rstrip!

            unless new_tag = Tag.find_by_name(article_tag)
              new_tag = Tag.create({name: article_tag})
            end

            ArticleTag.create({ tag_id: new_tag.id, article_id: @article.id })
          end
        end

        if params[:article][:writers]
          params[:article][:writers].each do |writer|
            WriterArticle.create({ article_id: @article.id, writer_id: writer.to_i })
          end
        end

        @article.update_formatted_writers_names

        if params[:article][:featured_media_id_string]
          media_ids = params[:article][:featured_media_id_string].split(' ')

          if media_ids.length > 1
            featured_media_collection = MediaCollection.create

            media_ids.each do |id|
              MediaCollectionContent.create({ medium_id: id.to_i, media_collection_id: featured_media_collection.id })
            end

            @article.update({ featured_media_is_collection: true, featured_media_id: featured_media_collection.id })
          else
            @article.update({ featured_media_id: media_ids[0].to_i })
          end
        end

        render json: { article: @article }, status: 201
      else
        render json: { errors: @article.errors }, status: 422
      end
    end

  private

    def article_params
      params.require(:article).permit(:featured_media_id, :article_type_id, :section_id, :featured_media_is_collection, :published, :private, :disable_comments, :headline, :subheading, :raw_contents, :importance)
    end
  end
end