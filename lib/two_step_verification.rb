class TwoStepVerification
  attr_accessor :user

  def initialize(user = nil)
    @user = user
    @error_message = "Temporary issue in sending OTP. Please try again later."
  end

  # generate OTP for 2-step verification & send SMS & mail
  def call
    return 'User missing' unless user
    if generate_otp
      send_otp_via_email
      send_otp_via_sms
    else
      user.errors.add(:base, error_message) 
    end
  end

  private

  # generates a random OTP for the user
  def generate_otp
    user.otp = rand(1000..9999).to_s.rjust(4, '0')
    user.save
  end

  # send OTP on phone number registered for the user
  def send_otp_via_sms
    twilio_service = Twilio::MessageService.new(user)
    twilio_service.send_otp
  end

  # send OTP on email registered for the user
  def send_otp_via_email
    begin 
      UserMailer.with(user: user).otp_email.deliver_now
    rescue => e
      user.errors.add(:base, error_message)
    end
  end
end