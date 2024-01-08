# frozen_string_literal: true

module Twilio
  # to handle message related services of Twilio
  class MessageService < Base
    # send OTP to user registered phone number
    def send_otp
      begin
        return 'User not present' unless user
        return 'Phone number is missing' unless user.phone_number
        return 'Generate OTP again' unless user.otp

        message = client.messages.create(
          from: TWILIO_PHONE_NUMBER,
          to: user.phone_number,
          body: "Your Login OTP is #{user.otp}. Please do not share your OTP with anyone."
        )

        user.update(twilio_message_sid: message.sid)
      rescue => e
        Rails.logger.error(">>>>>>>>>>>>>>>>>>>#{e.message}##################")
        return 'Invalid phone number' if e.message.include?("Invalid 'To' Phone Number")
      end
    end
  end
end
