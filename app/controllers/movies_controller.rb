require 'HTTParty'

class MoviesController < ApplicationController

  def index
    @movies= Movie.all
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def search

  end

  def results
    @movie = Movie.new
    if params[:search]
      @movie_list = []
      movie = params[:search]
      query = search_api(movie)
      @movie_list = query['Search'].compact
      @movies = @movie_list.map do |m|
        Movie.new(title: m['Title'], year: m['Year'], poster: m['Poster'], imdbid: m['imdbID'])
      end
    else
      flash[:notice] = "That didn't work out"
    end
    render :search
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.where(imdbid: params[:movie][:imdbid]).first_or_create do |movie|
      result = return_api(params[:movie][:imdbid])

      movie.title = result['Title']
      movie.year = result['Year']
      movie.genre = result['Genre']
      movie.director = result['Director']
      movie.poster = result['Poster']
      movie.plot = result['Plot']
    end
    redirect_to (@movie)
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
