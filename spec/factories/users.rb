FactoryGirl.define do
  factory :user do
    full_name { "Test user" }
    sequence(:email) {|n| "test+#{n}@example.com"}
    password { 'password' }
    phone_number { '+919999999999' }
  end
end
