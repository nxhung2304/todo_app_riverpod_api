class GoogleTokenVerifierService
  def initialize(google_client_id)
    @google_client_id = google_client_id
  end

  def call(params)
    id_token = params[:id_token]

    raise "ID token is required" if id_token.blank?

    begin
      payload = Google::Auth::IDTokens.verify_oidc(
        id_token,
        aud: @google_client_id
      )

      render_success(payload)
    rescue Google::Auth::IDTokens::VerificationError => e
      render_error("Invalid Google token: #{e.message}")
    rescue => e
      render_error("Verification failed: #{e.message}")
    end
  end

  private

    def render_success(payload)
      {
        success: true,
        user_data: {
          email: payload["email"],
          name: payload["name"],
          picture: payload["picture"],
          email_verified: payload["email_verified"],
          google_id: payload["sub"]
        }
      }
    end

    def render_error(e)
      {
        success: false,
        error: "Invalid Google token: #{e.message}"
      }
    end
end
