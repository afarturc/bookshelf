class BooksController < ApplicationController
  before_action :set_book, only: %i[show]

  def index
    @books = Book.all.order(created_at: :asc)
  end

  def show; end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
