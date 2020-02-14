class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = current_user.movies
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end


  def new
    @movie = Movie.new
  end

  def create
    query = params[:movie][:imdbid]
    if @movie = Movie.find_by(imdbid: query)
      redirect_to @movie
    elsif set_movie(query).save
      redirect_to @movie
    else
      flash[:notice] = "Invalid entry"
      @movies = Movie.all
      render :index
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
