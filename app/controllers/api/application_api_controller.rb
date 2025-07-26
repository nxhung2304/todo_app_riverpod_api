module Api
  class ApplicationApiController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    before_action :authenticate_api_user!

    def render_error_json(error_message, status = 404)
      render json: {
        message: error_message,
        success: false,
        timestamp: Time.current.iso8601
      }, status: status
    end

    def render_success_json(message = nil, data = nil, status = 200)
      response_body = {
        success: true,
        timestamp: Time.current.iso8601,
        data: data
      }

      response_body[:message] = message if message.present?

      render json: response_body, status: status
    end

    private

      def record_not_found(exception)
        render_error_json("Record not found", 404)
      end

      def record_invalid(exception)
        render_error_json(exception.record.errors.full_messages.join(", "), 422)
      end

      def parameter_missing(exception)
        render_error_json("Required parameter missing: #{exception.param}", 400)
      end
  end
end
