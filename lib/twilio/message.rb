module Twilio
  # to handle message related services of Twilio
  class Message < Base
    # send OTP to user registered phone number
    def send_otp
      begin
        message = client.messages.create(
          from: TWILIO_PHONE_NUMBER,
          to: user.phone_number,
          body: "Your Login OTP is #{user.otp}. Please do not share your OTP with anyone."
        )
        user.update(twilio_message_sid: message.sid)
      rescue => e
        message = 'Phone number missing' if e.message.include?("A 'To' phone number is required.")
        message = 'Invalid phone number' if e.message.include?("Invalid 'To' Phone Number")
        user.errors.add(:base, message || "Temporary issue in sending SMS. Please try again later.")
      end
    end
  end
end
