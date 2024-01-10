Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#dashboard"
  get '/verify_otp', to: 'two_factor#verify_otp'
  post '/verify_otp', to: 'two_factor#otp_verification'
  get '/resend_otp', to: 'two_factor#resend_otp'

  get '/generate_export', to: 'file_exports#index'
end
