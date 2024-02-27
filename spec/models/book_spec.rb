require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }

  describe "validations" do
    it { expect(book).to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:cover_url) }
  end

  describe "associations" do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_one(:active_reservation) }
    it { is_expected.to have_many(:readers) }
    it { is_expected.to have_one(:active_reader) }
  end

  describe "#available?" do
    context "when book is available" do
      it "must be true" do
        expect(book.available?).to eq(true)
      end
    end

    context "when book isn't available" do
      before do
        create(:reservation, book: book)
        book.reload
      end
      it "must be false" do
        expect(book.available?).to eq(false)
      end
    end
  end

  describe "#reserved?" do
    context "when book is reserved" do
      before do
        create(:reservation, book: book)
        book.reload
      end
      it "must be true" do
        expect(book.reserved?).to eq(true)
      end
    end

    context "when book isn't reserved" do
      it "must be false" do
        expect(book.reserved?).to eq(false)
      end
    end
  end
end
