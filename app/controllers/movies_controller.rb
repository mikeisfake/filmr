require 'HTTParty'

class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    @movie = Movie.new
    if params[:search]
      @movie_list = []
      movie = params[:search]
      query = search_api(movie)
      if !query['Search'].nil?
        @movie_list = query['Search'].compact.map do |m|
          if m['Poster']== 'N/A'
            m['Poster'] = 'https://66.media.tumblr.com/5a186c216ce45dbc68730be8ced57a06/e872194058456955-3c/s400x600/68cd75aef527634109c5573a4ef945941dc451b2.png'
          end
          Movie.new(title: m['Title'], year: m['Year'], poster: m['Poster'], imdbid: m['imdbID'])
        end
      else
        flash[:notice] = "No results bro"
      end
    else
      flash[:notice] = "That didn't work out"
    end
    render :index
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
