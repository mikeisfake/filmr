class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @movies = Movie.user_movies(@user)
    else
      @user = current_user
      @movies = Movie.user_movies(@user)
    end
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
