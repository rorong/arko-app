class UserMailer < ApplicationMailer
  # send OTP mail for login
  def otp_email
    @user = params[:user]

    mail(to: @user.email, subject: 'OTP for login')
  end
end
