require 'rails_helper'

RSpec.describe 'FileExportController', type: :request do
  let(:user) { create(:user) }

  describe "GET /generate_export" do
    context 'when user is not logged in' do
      before { get '/generate_export' }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }

      context 'when csv format' do
        context 'when selected_option not passed' do
          before { get '/generate_export.csv' }
    
          it 'displays error' do
            expect(flash[:alert]).to eq "Requested data not found"
          end
        end
  
        context 'when invalid selected_option passed' do
          before do
            get '/generate_export.csv', params: { selected_option: 'qwertyy' }
          end
    
          it 'displays error' do
            expect(flash[:alert]).to eq "Requested data not found"
          end 
        end

        context 'when valid selected_option passed' do
          before do
            get '/generate_export.csv', params: { selected_option: 'User' }
          end
    
          it 'returns data successfully' do
            expected_response = "id,email,encrypted_password,reset_password_token,reset_password_sent_at,remember_created_at,full_name,phone_number,otp,twilio_message_sid,is_otp_verified\n#{user.id},#{user.email},#{user.encrypted_password},#{user.reset_password_token},#{user.reset_password_sent_at},#{user.remember_created_at},#{user.full_name},#{user.phone_number},#{user.otp},#{user.twilio_message_sid},#{user.is_otp_verified}\n"
            expect(response.body).to eq expected_response
          end 
        end
      end

      context 'when xlsx format' do
        context 'when selected_option not passed' do
          before { get '/generate_export.xlsx' }
    
          it 'displays error' do
            expect(flash[:alert]).to eq "Requested data not found"
          end
        end
  
        context 'when invalid selected_option passed' do
          before do
            get '/generate_export.xlsx', params: { selected_option: 'qwertyy' }
          end
    
          it 'displays error' do
            expect(flash[:alert]).to eq "Requested data not found"
          end 
        end

        context 'when valid selected_option passed' do
          before do
            get '/generate_export.xlsx', params: { selected_option: 'User' }
          end
    
          it 'returns data successfully' do
            expect(flash[:alert]).to eq nil
          end
        end
      end
    end
  end
end
