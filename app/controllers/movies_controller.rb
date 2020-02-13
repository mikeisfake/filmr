require 'HTTParty'

class MoviesController < ApplicationController

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
    if Movie.find_by(imdbid: params[:movie][:imdbid])
      @movie = Movie.find_by(imdbid: params[:movie][:imdbid])
      redirect_to @movie
    else
      result = return_api(params[:movie][:imdbid])
      @movie = Movie.new(
        title: result['Title'],
        year: result['Year'],
        genre: result['Genre'],
        director: result['Director'],
        poster: result['Poster'],
        plot: result['Plot'],
        imdbid: result['imdbID']
      )
      if @movie.save
        redirect_to @movie
      else
        flash[:notice] = "Invalid entry"
        @movies = Movie.all
        render :index
      end
    end

  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
