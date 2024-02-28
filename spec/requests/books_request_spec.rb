require 'rails_helper'

RSpec.describe Book, type: :request do
  describe "GET #index" do
    it "returns existing book collection" do
      get root_path

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/html; charset=utf-8")
        expect(response.body).to include(*Book.pluck(:title))
      end
    end
  end

  describe "POST #create" do
    context "when params are valid" do
      let(:book_params) do
        {
          book: {
            title: FFaker::Book.title,
            description: FFaker::Book.description,
            cover_url: FFaker::Book.cover
          }
        }
      end

      it "creates a new book and redirects" do
        aggregate_failures do
          expect { post books_path(book_params) }.to change(Book, :count).by(1)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(books_path)
        end
      end
    end

    context "when params are missing" do
      let(:missing_params) do
        {
          book: {
            description: FFaker::Book.description,
          }
        }
      end

      it "does not create a new book" do
        aggregate_failures do
          expect { post books_path(missing_params) }.not_to change(Book, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
