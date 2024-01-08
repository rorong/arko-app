class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :full_name])
  end

  def after_sign_up_path_for(resource)
    sign_out resource
    flash.now[:success] = 'Successfully registered. Please login to proceed.'
    new_user_session_path
  end
end
