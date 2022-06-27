# frozen_string_literal: true

module Api
  module V1
    module Iam
      class RegistrationsController < Devise::RegistrationsController
        # include ApiErrors::ErrorHandler
        include HttpAcceptLanguage::AutoLocale

        def create
          render json: register_user, serializer: UserSerializer
        end

        # def update
        #   super
        # end

        # def destroy
        #   super
        # end

        # GET /resource/cancel
        # Forces the session data which is usually expired after sign
        # in to be expired now. This is useful if the user wants to
        # cancel oauth signing in/up in the middle of the process,
        # removing all OAuth session data.
        # def cancel
        #   super
        # end

        protected

        def sign_up_params
          params.require(:sign_up).permit(
            :email,
            :password,
            :password_confirmation,
            profile_attributes: %i[
              first_name
              last_name
              phone_number
            ]
          )
        end

        def register_user
          ::Auth::Register.call(self, sign_up_params)
        end

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_account_update_params
        #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
        # end

        # The path used after sign up.
        # def after_sign_up_path_for(resource)
        #   super(resource)
        # end

        # The path used after sign up for inactive accounts.
        # def after_inactive_sign_up_path_for(resource)
        #   super(resource)
        # end
      end
    end
  end
end
