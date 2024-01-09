# for handling two factor authentication
class TwoFactorController < ApplicationController
  skip_before_action :verify_two_factor_authentication

  # GTE /resend_otp
  def resend_otp
    if ((DateTime.now.to_i - current_user.otp_sent_at.to_i) / 60) > 1
      TwoStepVerification.new(current_user).call
      flash[:alert] = current_user.errors.full_messages.join(', ') if current_user.errors.any?
    else
      flash[:alert] = 'Please wait for a min to activate resend'
    end
    redirect_to verify_otp_path
  end

  # POST /verify_otp
  def otp_verification
    if otp_params[:otp].present? && current_user.valid_otp?(otp_params[:otp])
      session[:is_otp_verified] = true
      redirect_to root_path
    else
      flash[:alert] = "Invalid OTP. Please try again."
      redirect_to verify_otp_path
    end
  end

  private

  def otp_params
    params.permit(:otp)
  end
end
