class HomeController < ApplicationController
  skip_before_action :verify_two_factor_authentication, except: [:dashboard]
  
  def dashboard
  end

  def verify_otp; end

  def resend_otp
    TwoStepVerification.new(current_user).call
    flash[:alert] = current_user.errors.full_messages.join(', ') if current_user.errors.any?
    redirect_to verify_otp_path
  end

  def otp_verification
    if otp_params[:otp].present? && current_user.valid_otp?(otp_params[:otp])
      session[:is_otp_verified] = true
      redirect_to root_path
    else
      flash[:alert] = "Invalid OTP. Please try again."
      redirect_to verify_otp_path
    end
  end

  def otp_params
    params.permit(:otp)
  end
end
