module Api
  class AuthController < ApplicationApiController
    GOOGLE_PROVIDER = "google"

    before_action :set_google_client_id, only: :google_login

    def google_login
      result = verify_google_token
      if result[:success]
        user = find_or_create_google_user(result[:user_data])
        auth_tokens = user.create_new_auth_token

        render_success_json(
          "Google authentication successful",
          { user: user, auth_tokens: auth_tokens }
        )
      else
        render_error_json("Google Token Verifier: Failed", 401)
      end
    rescue StandardError => e
      Rails.logger.error "Google login error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render_error_json("Authentication service unavailable: #{e}", 500)
    end

    private

    def set_google_client_id
      @google_client_id = ENV["GOOGLE_CLIENT_ID"]
      raise "GOOGLE_CLIENT_ID is empty" if @google_client_id.blank?
    end

    def google_login_params
      params.permit(:id_token)
    end

    def find_or_create_google_user(user_data)
      User.find_or_create_by(email: user_data[:email]) do |u|
          u.full_name = user_data[:name]
          u.provider = GOOGLE_PROVIDER
          u.uid = user_data[:email]
        end
    end

    def verify_google_token
      google_service = GoogleTokenVerifierService.new(@google_client_id)

      google_service.call(google_login_params)
    end
  end
end
