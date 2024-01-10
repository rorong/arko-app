require 'rails_helper'

RSpec.describe 'TwoFactorController', type: :request do
  let(:user) { create(:user) }

  describe "GET /verify_otp" do
    context 'when user is not logged in' do
      before { get '/verify_otp' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before do
        sign_in user
        get '/verify_otp'
      end

      it 'successfully loads the page' do
        expect(response).to have_http_status(200)
      end 
    end
  end

  describe "POST /verify_otp" do
    context 'when user is not logged in' do
      before { post '/verify_otp' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      context 'when OTP missing' do
        before do
          sign_in user
          post verify_otp_path(), params: { new_param: '' }
        end

        it 'displays error' do
          expect(flash[:alert]).to eq 'Invalid OTP. Please try again.'
        end
      end

      context 'when OTP is invalid' do
        before do
          sign_in user
          post verify_otp_path(), params: { otp: 'qwerty' }
        end

        it 'displays error' do
          expect(flash[:alert]).to eq 'Invalid OTP. Please try again.'
        end
      end

      context 'when OTP is valid' do
        let!(:user) { create(:user, otp: '1111') }

        before do
          sign_in user
          post verify_otp_path(), params: { otp: user.reload.otp }
        end

        it 'updates user detail' do
          expect(session[:is_otp_verified]).to eq true
        end

        it 'redirects to the root page' do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
