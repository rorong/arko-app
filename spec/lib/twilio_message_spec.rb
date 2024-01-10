require 'rails_helper'

describe Twilio::Message do
  subject { create(:user) }

  describe '#send_otp' do
    describe 'when phone number missing' do
      before { subject.update_attribute(:phone_number, nil) }

      it 'returns error' do
        resp = Twilio::Message.new(subject).send_otp
        expect(resp.type).to eq 'Phone number missing'
      end
    end
    
    describe 'when phone number is invalid' do
      before { subject.update_attribute(:phone_number, '1111') }
      
      it 'returns error' do
        resp = Twilio::Message.new(subject).send_otp
        expect(resp.type).to eq 'Invalid phone number'
      end
    end

    describe 'when all details valid' do
      before do
        subject.update(otp: '1111')
        Twilio::Message.new(subject.reload).send_otp
      end

      it 'successfully sends message' do
        expect(subject.reload.twilio_message_sid).not_to be_nil
      end
    end
  end
end
