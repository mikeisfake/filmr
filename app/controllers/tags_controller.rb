class ReviewsController < ApplicationController
  def create
    @review = Review.find(params[:id])
  end
end
