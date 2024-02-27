require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { expect(user).to be_valid }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe "associations" do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_one(:active_reservation) }
    it { is_expected.to have_one(:active_reading) }
  end

  describe "#actively_reading?" do
    context "when user is actively reading" do
      before do
        create(:reservation, user: user)
        user.reload
      end
      it "must be true" do
        expect(user.actively_reading?).to eq(true)
      end
    end

    context "when user isn't actively reading" do
      it "must be false" do
        expect(user.actively_reading?).to eq(false)
      end
    end
  end

  describe "#full_name" do
    it "combines the first name and last name of the user" do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
