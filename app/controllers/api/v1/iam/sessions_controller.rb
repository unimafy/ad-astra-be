# frozen_string_literal: true

module Api
  module V1
    module Iam
      class SessionsController < Devise::SessionsController
        def create
          render(
            json: Auth::Login.call(self, login_params),
            serializer: UserSerializer
          )
        end

        # DELETE /resource/sign_out
        # def destroy
        #   super
        # end

        protected

        # def respond_to_on_destroy
        #   warden.logout(current_user)
        #   CookieDestroyer.destroy(response)
        #   render json: { message: 'logged out' }
        # end

        def login_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
