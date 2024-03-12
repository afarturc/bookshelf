class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update reserve destroy]

  def index
    @books = Book.all.order(created_at: :asc)
  end

  def show; end

  def edit; end

  def new
    @book = Book.new
  end

  def create
    result = CreateBook.new(book_params).perform

    if result.success?
      respond_to do |format|
        format.html do
          flash[:notice] = "#{result.book.title} was successfully added to the collection"
          redirect_to(books_path)
        end
        format.json { render json: { book: result.book }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = result.errors
          render :new, status: :unprocessable_entity
        end
        format.json { render json: { errors: result.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = UpdateBook.new(@book, book_params).perform

    if result.success?
      respond_to do |format|
        format.html do
          flash[:notice] = "#{result.book.title} was successfully updated!"
          redirect_to(books_path)
        end
        format.json { render json: { book: result.book }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = result.errors
          render :edit, status: :unprocessable_entity
        end
        format.json { render json: { errors: result.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    result = DestroyBook.new(@book).perform

    if result.success?
      respond_to do |format|
        flash[:notice] = "#{result.book.title} was successfully removed from the collection"
        format.turbo_stream
        format.json { head :ok }
      end 
    else
      respond_to do |format|
        format.json { head :unprocessable_entity }
      end 
    end
  end

  def reserve
    result = ReserveBook.new(current_user, @book).perform

    if result.success?
      respond_to do |format|
        format.html do
          redirect_to(books_path, notice: "#{@book.title} was successfully reserved")
        end
        format.json { render json: { reservation: result.reservation }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = result&.errors
          render :show, status: :unprocessable_entity
        end
        format.json { render json: { errors: result&.errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :genre, :cover_url)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
