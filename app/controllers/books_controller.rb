class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @book_comment = BookComment.new
  end

  def index
    # params[:xxx]はviewのxxxと繋がっている。
    # @books = Book.yyyはmodelのyyyと繋がっている。
    if params[:latest]
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
    end

    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search_book
    @books = Book.search(params[:keyword])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :category)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end

end
