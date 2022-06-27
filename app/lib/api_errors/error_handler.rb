# frozen_string_literal: true

module ApiErrors
  module ErrorHandler
    def self.included(base)
      base.class_eval do
        rescue_from StandardError, with: :bad_request
        rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        rescue_from ActionController::ParameterMissing, with: :bad_request
        rescue_from NoMethodError, with: :bad_request
        rescue_from ActionController::MissingFile, with: :file_not_found
        rescue_from UnauthorizedError, with: :unauthorized
      end
    end

    def unauthenticated(error)
      render_error(:unauthorized, [error.message])
    end

    def unauthorized(error)
      render_error(:forbidden, [error.message])
    end

    def record_not_found(error)
      render_error(:not_found, [error.message])
    end

    def record_invalid(error)
      render_error(:unprocessable_entity, error.record.errors.full_messages)
    end

    def invalid_resource(record)
      render_error(:unprocessable_entity, record.errors.full_messages)
    end

    def invalid_card(error)
      render_error(:unprocessable_entity, [error.message])
    end

    def bad_request(error)
      render_error(:bad_request, [error.message])
    end

    def render_error(status, errors)
      render json: { type: 'standard', errors: errors }, status: status
    end
  end
end
