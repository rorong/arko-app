require 'rails_helper'

RSpec.describe 'HomeController', type: :request do
  let(:user) { create(:user) }

  describe "GET /" do
    context 'when user not logged in' do
      before { get '/' }
  
      it 'redirects to sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user logged in' do
      before do
        sign_in user
        get '/'
      end
  
      it 'successfully loads the page' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
