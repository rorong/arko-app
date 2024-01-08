require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'Associations' do
    it { is_expected.to have_one(:address_detail) }
  end
  
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone_number) }

    describe 'Email Validity' do
      context 'when email is invalid' do
        it 'returns error' do
          expect do
            subject.update(email: 'asdf')
          end.to change {
            subject.errors.full_messages.last
          }.from(nil).to('Email is invalid')
        end
      end

      context 'when email is valid' do
        it 'returns success' do
          expect do
            subject.update(email: 'qwerty@test.com')
          end.not_to change { subject.errors.full_messages.join(",") }.from('')
        end
      end
    end

    describe 'Phone number Validity' do
      context 'when phone number is invalid' do
        it 'returns error' do
          expect do
            subject.update(phone_number: 'asdf')
          end.to change {
            subject.errors.full_messages.join(",")
          }.from('').to('Phone number is invalid')
        end
      end

      context 'when phone number is valid without country code' do
        it 'returns error' do
          expect do
            subject.update(phone_number: '9999999999')
          end.to change {
            subject.errors.full_messages.join(",")
          }.from('').to('Phone number is invalid')
        end
      end

      context 'when phone number is valid with country code' do
        it 'returns success' do
          expect do
            subject.update(phone_number: '+919999999999')
          end.not_to change { subject.errors.full_messages.join(",") }.from('')
        end
      end
    end
  end
end
