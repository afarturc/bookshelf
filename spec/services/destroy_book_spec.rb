require 'rails_helper'

RSpec.describe DestroyBook do
    let(:destroy_book) { described_class.new(book).perform }

    describe "#perform" do
        context "when book exists" do
            let(:book) { create(:book) }

            it "destroys the book" do
                aggregate_failures do
                    expect(destroy_book.success?).to eq(true)
                    expect { book.reload }.to raise_error(ActiveRecord::RecordNotFound)
                end
            end
        end
    end
end