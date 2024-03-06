require 'rails_helper'

RSpec.describe Book, type: :request do
  describe "GET #index" do
    context "when logged in" do
      let(:user) { create(:user) }

      before do
        sign_in(user)
        create_list(:book, 5)
      end

      it "returns existing book collection" do
        get root_path

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(response.body).to include(*Book.pluck(:title))
        end
      end
    end

    context "when logged out" do
      it "redirects to login" do
        get books_path

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq("text/html; charset=utf-8")
        end
      end
    end
  end

  describe "GET #show" do
    subject(:book) { create(:book) }

    context "when logged in" do
      include_context 'with logged user'

      it "returns book details" do
        get book_path(book)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(response.body).to include(book.title)
        end
      end
    end

    context "when logged out" do
      it "redirects to login" do
        get book_path(book)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq("text/html; charset=utf-8")
        end
      end
    end
  end

  describe "GET #new" do
    context "when user logged in" do
      include_context 'with logged user'

      it "shows new book form" do
        get new_book_path

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(response.body).to include("Add a new book")
        end
      end
    end

    context "when user logged out" do
      it "redirects to login" do
        get new_book_path

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        end
      end
    end
  end

  describe "GET #edit" do
    subject(:book) { create(:book) }

    context "when user logged in" do
      include_context 'with logged user'

      it "shows edit book form" do
        get edit_book_path(book)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(response.body).to include("Edit")
          expect(response.body).to include(book.title)
        end
      end
    end

    context "when user logged out" do
      it "redirects to login" do
        get edit_book_path(book)

        aggregate_failures do
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        end
      end
    end
  end

  describe "POST #create" do
    context "when logged in" do
      include_context "with logged user"

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

  describe "PATCH #update" do
    context "when logged in" do
      include_context "with logged user"

      let!(:book) { create(:book) }

      context "when params are valid" do
        let(:book_params) do
          {
            book: {
              description: FFaker::Book.description,
            }
          }
        end

        it "updates a new book and redirects" do
          aggregate_failures do
            expect { patch book_path(book, book_params) }.not_to change(Book, :count)
            expect(response).to have_http_status(:found)
            expect(flash[:notice]).to eq("#{book.title} was successfully updated!")
            expect(response).to redirect_to(books_path)
          end
        end
      end

      context "when params are invalid" do
        let(:invalid_params) do
          {
            book: {
              description: nil,
            }
          }
        end
        let(:validation_errors) { ["Description can't be blank"] }

        it "does not update a book" do
          aggregate_failures do
            expect { patch book_path(book, invalid_params) }.not_to change(Book, :count)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(flash[:alert]).to eq(validation_errors)
          end
        end
      end
    end
  end

  describe "POST #reserve" do
    subject(:book) { create(:book) }

    context "when user is logged in" do
      include_context "with logged user"

      it "creates a new reservation and redirects" do
        aggregate_failures do
          expect { post reserve_book_path(book.id) }.to change(Reservation, :count).by(1)
          expect(response).to redirect_to(books_path)
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq("#{book.title} was successfully reserved")
        end
      end
    end

    context "when user is logged out" do
      it "does not create a new reservation and redirects to login" do
        aggregate_failures do
          expect { post reserve_book_path(book.id) }.not_to change(Reservation, :count)
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(:found)
          expect(response.content_type).to eq("text/html; charset=utf-8")
          expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
        end
      end
    end
  end
end
