module Staff
  class UsersController < StaffController
    def new
      render text: '', layout: true
    end

    def forgot_password
      render text: '', layout: true
    end
  end
end