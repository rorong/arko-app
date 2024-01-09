class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :verify_two_factor_authentication


  private

  def verify_two_factor_authentication
    redirect_to verify_otp_path if !session[:is_otp_verified].nil? && !session[:is_otp_verified].present?
  end

end