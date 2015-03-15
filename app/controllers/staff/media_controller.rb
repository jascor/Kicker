module Staff
  class MediaController < StaffController
    def index
      @media = Medium.all

      render 'many'
    end

    def show
      @media = Medium.find(params[:id])

      render 'single'
    end

    def create
      @media = Medium.new(media_params)

      if @media.save
        render json: @media, status: 201
      else
        render json: @media.errors.full_messages
      end
    end

    def update
      @media = Medium.find(params[:id])

      @media.update(media_params)

      render 'single'
    end

    def pending
      @media = Medium.where(pending_initial_edit: true)

      render 'many'
    end

  private

    def media_params
      params.require(:medium).permit(:filename, :mime_type, :link, :secure_link, :s3_key, :title, :caption, :credit)
    end
  end
end