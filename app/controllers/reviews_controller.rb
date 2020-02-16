class ReviewsController < ApplicationController

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit]
  before_action :authenticate_user!

  def index
    @user = User.find_by(id: params[:user_id])
    @reviews = @user.reviews
  end

  def new
    @movie = Movie.find_by(id: params[:movie_id])
    @review = Review.new(movie_id: params[:movie_id])
  end

  def create
    movie = Movie.find_by(id: params[:review][:movie_id])
    review = Review.new(review_params)
    if review.save
      flash[:notice] = "what a witty review"
      redirect_to review_path(review)
    else
      flash[:alert] = "that didn't work out"
      redirect_to new_movie_review_path
    end
  end

  def show
  end

  def edit
    if !@review.owns? current_user
      redirect_to root_path
      flash[:alert] = "you don't have permission to do that."
    end
  end

  def update
    @review.update(review_params)
    flash[:notice] = "nice update"
    redirect_to @review
  end

  def destroy
    @review.destroy
    flash[:alert] = "wooosh that review is gone forever."
    redirect_to root_path
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_movie
    @movie = @review.movie
  end

  def review_params
    params.require(:review).permit(:content, :date, :tag_name, :movie_id, :user_id)
  end
end
