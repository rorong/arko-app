class TwoStepVerification
  attr_accessor :user, :error_message

  def initialize(user = nil)
    @user = user
    @error_message = "Temporary issue in sending OTP. Please try again later."
  end

  # generate OTP for 2-step verification & send SMS & mail
  def call
    return 'User missing' unless user
    if last_otp_sent < 1
      user.errors.add(:base, 'Please wait for a min to activate resend')
    elsif generate_otp
      send_otp_via_email
      send_otp_via_sms
    else
      user.errors.add(:base, error_message) 
    end
  end

  private

  # returns last otp sent time wrt current time in minutes
  def last_otp_sent
    (DateTime.now.to_i - user.otp_sent_at.to_i) / 60
  end

  # generates a random OTP for the user
  def generate_otp
    user.otp = rand(1000..9999).to_s.rjust(4, '0')
    user.otp_sent_at = DateTime.now
    user.save
  end

  # send OTP on phone number registered for the user
  def send_otp_via_sms
    twilio_service = Twilio::Message.new(user)
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