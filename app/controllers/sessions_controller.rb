class SessionsController < Devise::SessionsController
  def new
    super
  end

  # create session for user to login
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    TwoStepVerification.new(current_user).call
    session[:is_otp_verified] = false
    flash[:alert] = current_user.errors.full_messages.join(', ') if current_user.errors.any?
    redirect_to verify_otp_path
  end

  def destroy
    user = current_user
    if user.update(otp: nil, is_otp_verified: false)
      super
    else
      flash[:alert] = 'Something went wrong. Please try again.'
      redirect_to root_path
    end
  end
end
