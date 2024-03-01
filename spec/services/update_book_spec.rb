require 'rails_helper'

RSpec.describe UpdateBook do
  let(:book) { create(:book) }
  let(:update_book) { described_class.new(book, book_params).perform }

  describe "#perform" do
    context "when params are valid" do
      let(:book_params) do
        {
          title: FFaker::Book.title,
          description: FFaker::Book.description,
        }
      end

      it "updates a book" do
        aggregate_failures do
          expect(update_book.success?).to eq(true)
          expect(Book.last.title).to eq(book_params[:title])
          expect(Book.last.description).to eq(book_params[:description])
        end
      end
    end

    context "when params are invalid" do
      let(:book_params) do
        {
          title: nil,
          cover_url: nil,
        }
      end
      let(:expected_error_messages) do
        ["Title can't be blank", "Cover url can't be blank"]
      end

      it "does not update a book" do
        aggregate_failures do
          expect(update_book.success?).to eq(false)
          expect(update_book.errors).to eq(expected_error_messages)
        end
      end
    end
  end
end
