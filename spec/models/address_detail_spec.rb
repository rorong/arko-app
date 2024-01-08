require 'rails_helper'

RSpec.describe AddressDetail, type: :model do
  subject { create(:address_detail) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end
end
