class TwoStepVerification
  attr_accessor :user
  def initialize(user = nil)
    @user = user
  end

  # generate OTP for 2-step verification & send SMS & mail
  def call
    return 'User missing' unless user

    generate_otp
    send_otp_via_sms
    send_otp_via_email
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
    UserMailer.with(user: user).otp_email.deliver_now
  end
end
