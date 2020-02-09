class ReviewsController < ApplicationController

  def new
    if params[:movie_id]
      @movie = Movie.find_by(id: params[:movie_id])
      @review = Review.new(movie_id: params[:movie_id])
    end
  end

  def create
    @movie = Movie.find_by(id: params[:review][:movie_id])
    @review = Review.create(review_params)
    @movie.reviews << @review
    redirect_to movie_path(@movie)
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to @review
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:content, :date)
  end
end
