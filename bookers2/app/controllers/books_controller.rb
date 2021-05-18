class BooksController < ApplicationController
  before_action :ensure_user_book, only: [:edit]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
    @books = Book
  end

  def destroy
    @book = Book.find(params[:id])
    @user = User.find_by(profile_image_id: @book.user_id)
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def ensure_user_book
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
