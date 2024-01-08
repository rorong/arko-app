require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'Associations' do
    it { is_expected.to have_one(:address_detail) }
  end
end
