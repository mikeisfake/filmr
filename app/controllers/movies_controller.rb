class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action only: [:index, :show] do
    set_movie_list(params[:search])
  end

  def index
    @movies = Movie.user_movies(current_user)
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def new
  end

  def create
    find_or_create_movie params[:imdbid] if params[:imdbid]
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
