module Staff
  class SectionsController < StaffController
    def index
      sections = Section.all

      render json: { section: sections }
    end

    def show
      @section = Section.includes(section_page_sections: :section_page_section_contents).find(params[:id])
    end

    def organize

    end
  end
end