module Staff
  class MediaController < StaffController
    def index
      media = Medium.all

      render json: { media: media }
    end

    def new

    end

    def create
      @media = Medium.new(media_params)

      if @media.save
        render json: @media, status: 201
      else
        render json: @media.errors.full_messages
      end
    end

  private

    def media_params
      params.require(:medium).permit(:filename, :mime_type, :link, :secure_link, :s3_key)
    end
  end
end