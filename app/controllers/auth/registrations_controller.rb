class Auth::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  def respond_with(user, _opts = {})
    return render json: user.error_messages, status: :bad_request unless user.valid?
    render json: user, status: :created
  end

  def respond_to_on_destroy
    head :ok
  end
end
