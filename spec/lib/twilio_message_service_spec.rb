require 'rails_helper'

describe Twilio::MessageService do
  subject { create(:user) }

  describe '#send_otp' do
    describe 'when user missing' do
      it 'returns error' do
        expect(Twilio::MessageService.new.send_otp).to eq 'User not present'
      end
    end

    describe 'when phone number missing' do
      let!(:user) { create(:user, phone_number: nil) }

      it 'returns error' do
        expect(Twilio::MessageService.new(user).send_otp).to eq 'Phone number is missing'
      end
    end

    describe 'when user OTP missing' do
      it 'returns error' do
        expect(Twilio::MessageService.new(subject).send_otp).to eq 'Generate OTP again'
      end
    end
    
    describe 'when OTP present but phone number is invalid' do
      let!(:user) { create(:user, otp: '1111', phone_number: '1111') }
      
      it 'returns error' do
        expect(Twilio::MessageService.new(user).send_otp).to eq 'Invalid phone number'
      end
    end

    describe 'when all details valid' do
      before do
        subject.update(otp: '1111')
        Twilio::MessageService.new(subject.reload).send_otp
      end

      it 'successfully sends message' do
        expect(subject.reload.twilio_message_sid).not_to be_nil
      end
    end
  end
end
