module Staff
  class SectionsController < StaffController
    def index
      sections = Section.all

      render json: { section: sections }
    end

    def show
      section = Section.find(params[:id])

      render json: { section: section }
    end

    def organize

    end
  end
end