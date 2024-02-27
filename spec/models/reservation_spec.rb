require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject(:reservation) { build(:reservation) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
