FactoryGirl.define do
  factory :address_detail do
    street { 'tes' }
    landmark { 'test' }
    state { 'test' }
    country { 'test' }
    user { FactoryGirl.create(:user) }
  end
end
