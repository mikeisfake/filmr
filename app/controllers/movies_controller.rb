class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.user_movies(current_user)
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end


  def new
    @movie = Movie.new
  end

  def create
    find_or_create_movie params[:movie][:imdbid] if params[:movie][:imdbid]
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
