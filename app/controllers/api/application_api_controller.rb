module Api
  class ApplicationApiController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken

    def render_error_json(error_message, status = 404)
      render json: {
        message: error_message,
        success: false
      }, status: status
    end

    def render_success_json(success_message, status = 200)
      render json: {
        message: success_message,
        success: true
      }, status: status
    end
  end
end
