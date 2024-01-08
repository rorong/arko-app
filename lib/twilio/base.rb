# frozen_string_literal: true

module Twilio
  # base class to initialize Twilio client & other common methods
  class Base
    TWILIO_ACCOUNT_SID = Rails.application.credentials[:TWILIO_ACCOUNT_SID]
    TWILIO_AUTH_TOKEN = Rails.application.credentials[:TWILIO_AUTH_TOKEN]
    TWILIO_PHONE_NUMBER = Rails.application.credentials[:TWILIO_PHONE_NUMBER]
  
    attr_accessor :client, :user

    def initialize(user = nil)
      initialize_client
      @user = user
    end
    
    private
    
    def initialize_client
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    end
  end
end
