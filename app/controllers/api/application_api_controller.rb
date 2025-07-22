module Api
  class ApplicationApiController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

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
        timestamp: Time.current.iso8601
      }

      response_body[:message] = message if message.present?
      response_body[:data] = data if data.present?

      render json: response_body, status: status
    end

     private

    def record_not_found(exception)
      render_error_json("Record not found", 404, "RECORD_NOT_FOUND")
    end

    def record_invalid(exception)
      render_error_json(exception.record.errors.full_messages.join(", "), 422, "VALIDATION_ERROR")
    end

    def parameter_missing(exception)
      render_error_json("Required parameter missing: #{exception.param}", 400, "MISSING_PARAMETER")
    end
  end
end
