module Staff
  class ArticleTypesController < StaffController
    def index
      types = ArticleType.all

      render json: { articleTypes: types }
    end
  end
end