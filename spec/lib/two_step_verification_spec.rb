require 'rails_helper'

describe TwoStepVerification do
  subject { create(:user) }

  describe 'call' do
    context 'when user missing' do
      it 'returns error message' do
        expect(TwoStepVerification.new.call).to eq 'User missing'
      end
    end

    context 'when correct user passed' do
      before { TwoStepVerification.new(subject).call }
      
      it 'successfully generates OTP' do
        expect(subject.reload.otp).not_to be_nil
      end
    end
    
    context 'when incorrect phone number registered for the user' do
      # invalid number as the country code is missing
      let!(:user) { create(:user) }
      before { user.update_attribute(:phone_number, '222222222') }

      it 'does not send OTP via SMS' do
        TwoStepVerification.new(user).call
        expect(user.twilio_message_sid).to be_nil
      end

      it 'does not send OTP via mail' do
        expect do
          TwoStepVerification.new(user).call
        end.not_to change { ActionMailer::Base.deliveries.size }
      end
    end

    context 'when correct phone number registered for the user' do
      before { TwoStepVerification.new(subject).call }

      it 'successfully sends OTP via mail' do
        expect do
          TwoStepVerification.new(subject).call
        end.to change { ActionMailer::Base.deliveries.size }.by(1)
      end
    end
  end
end
