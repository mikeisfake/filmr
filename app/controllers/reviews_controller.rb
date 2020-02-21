class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find_by(id: params[:user_id])
    @reviews = @user.reviews
  end

  def new
    @movie = Movie.find_by(id: params[:movie_id])
    @review = Review.new(movie_id: params[:movie_id])
  end

  def create
    @movie = Movie.find_by(id: params[:review][:movie_id])
    @review = Review.new(review_params)
    if @review.save
      update_or_create_watchlist
    else
      render :new
    end
  end

  def show
  end

  def edit
    if !@review.owns? current_user
      redirect_to root_path, alert: "you don't have permission to do that."
    end
  end

  def update
    @review.update(review_params)
    redirect_to @review, notice: "finished polishing up your review of #{@review.movie.title}"
  end

  def destroy
    @review.destroy
    redirect_to user_path(current_user), alert: "your review of #{@review.movie.title} is gonve forever."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end


  def review_params
    params.require(:review).permit(:content, :date, :tag_name, :movie_id, :user_id)
  end
end
