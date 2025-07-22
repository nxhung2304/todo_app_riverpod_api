module Api
  class AuthController < ApplicationApiController
    before_action :set_google_client_id, only: :google_login

    def google_login
      google_service = GoogleTokenVerifierService.new(@google_client_id)

      result = google_service.call(google_login_params)

      render_success_json("Google Token Verifier success")
      rescue StandardError => e
        render_error_json(e, 403)
    end

    private

    def set_google_client_id
      @google_client_id = ENV["GOOGLE_CLIENT_ID"]
      raise "GOOGLE_CLIENT_ID is empty" if @google_client_id.blank?
    end

    def google_login_params
      params.permit(:id_token)
    end
  end
end
