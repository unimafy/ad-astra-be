# frozen_string_literal: true

module Auth
  class Login < Base
    def run
      remove_session_cookie
      authenticate_user && @user
    end

    private

    def remove_session_cookie
      request.cookies.delete('_iam_session')
    end

    def authenticate_user
      @user = controller.warden.authenticate!(auth_options)
    end

    def user
      @user ||= User.find_by(email: params['email'])
    end

    def auth_options
      controller.send(:auth_options)
    end
  end
end
