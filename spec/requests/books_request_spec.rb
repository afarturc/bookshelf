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

  describe "GET #show" do
    let(:book) { create(:book) }

    it "returns book details" do
      get book_path(book)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/html; charset=utf-8")
        expect(response.body).to include(book.title)
      end
    end
  end
end
