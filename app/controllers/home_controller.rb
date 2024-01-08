class HomeController < ApplicationController
  before_action :get_current_user, only: [:verify_otp, :otp_verification]
  before_action :set_otp_details, only: [:verify_otp]
  before_action :verify_two_factor_authentication, except: [:verify_otp, :otp_verification]

  def dashboard
  end

  def verify_otp
  end

  def otp_verification
    if otp_params[:otp].present? && current_user.valid_otp?(otp_params[:otp])
      current_user.update(is_otp_verified: true)
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid OTP. Please try again."
      set_otp_details
      render :verify_otp
    end
  end

  private

  def verify_two_factor_authentication
    if current_user.present?
      redirect_to verify_otp_path unless current_user.is_otp_verified
    end
  end

  def get_current_user
    unless current_user
      flash[:alert] = "User not found. Please try sign in again."
      redirect_to new_user_session_path
    end

    current_user
  end

  def set_otp_details
    @user = current_user.dup
    @user.otp = nil
  end

  def otp_params
    params.require(:user).permit(:otp)
  end
end
