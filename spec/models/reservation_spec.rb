require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject(:reservation) { create(:reservation) }

  describe "validations" do
    context "when reserve attempts happen on already reserved book" do
      let(:book) { create(:book) }

      before do
        create(:reservation, book: book)
        book.reload
      end

      it "raise a validation error" do
        expect { create(:reservation, book: book) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when user attempts to reserve more than one book" do
      let(:user) { create(:user) }

      before do
        create(:reservation, user: user)
        user.reload
      end

      it "raise a validation error" do
        expect {  create(:reservation, user: user) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when reservation ends in a past date" do
      it "raise a validation error" do
        expect { create(:reservation, returned_on: Date.yesterday) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when already finished reservation is altered" do
      let!(:reservation) { create(:reservation, returned_on: Date.today) }

      it "raise a validation error" do
        expect { reservation.update!(returned_on: Date.tomorrow) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end
end
