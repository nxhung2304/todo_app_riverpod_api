class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  # protect_from_forgery with: :null_sessirn
end
