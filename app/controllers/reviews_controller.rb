class ReviewsController < ApplicationController

  def new
    if params[:movie_id]
      @movie = Movie.find_by(id: params[:movie_id])
      @review = Review.new(movie_id: params[:movie_id])
    end
  end

  def create
    @movie = Movie.find_by(id: params[:movie_id])
    @review = Review.create(content: params[:review][:content])
  end

  private

  def review_params
    params.require(:review).permit(:content, :date, :movie_id)
  end
end
