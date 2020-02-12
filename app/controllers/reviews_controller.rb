class ReviewsController < ApplicationController

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_movie, only: [:show, :edit]
  before_action :authenticate_user!

  def new
    @movie = Movie.find_by(id: params[:movie_id])
    @review = Review.new(movie_id: params[:movie_id])
  end

  def create
    movie = Movie.find_by(id: params[:review][:movie_id])
    review = Review.new(review_params)
    if review.save
      redirect_to movie_path(movie)
    else
      flash[:notice] = "that didn't work out"
    end
  end

  def show
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to @review
  end

  def destroy
    @review.destroy
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
