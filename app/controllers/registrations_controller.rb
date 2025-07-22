class RegistrationsController < DeviseTokenAuth::RegistrationsController
  protected

  def render_create_error
    render json: {
      status: "error",
      errors: resource_errors[:full_messages]
    }, status: :unprocessable_entity
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :full_name)
  end

  def account_update_params
    params.permit(:email, :password, :password_confirmation, :full_name)
  end
end
