# README



Create dummy data stored in seed. Run following command in terminal.
rails db:seed

To send OTP via SMS -
  You need to create a test account for Twilio - https://www.twilio.com/login

  Run the below command in terminal to update credential file
  EDITOR=nano rails credentials:edit

  Add following credentials for twilio in the editor -
  TWILIO_ACCOUNT_SID: '<your twilio account SID>'
  TWILIO_AUTH_TOKEN: '<your twilio account auth token>'
  TWILIO_PHONE_NUMBER: '<your twilio account phone number>'

To send OTP via mail -
  In development, the OTP mail is sent via letter opener in the browser itself.
  To configure, gmail SMTP setting in development

  In /config/environments/development.rb
  replace 
  config.action_mailer.delivery_method = :letter_opener

  with
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: '<your gmail username>',
    password: '<your gmail app password>',
    authentication: 'plain',
    enable_starttls_auto: true
  }

