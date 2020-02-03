require 'HTTParty'

class MoviesController < ApplicationController
  # include APIable

  def index
    @movies= Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    if params[:search]
      @movie_list = []
      movie = params[:search]

      query = HTTParty.get('http://www.omdbapi.com/?s=' + movie + '&apikey=2cedcff3&')
      if query['Error'].nil?
        @movie_list = query['Search'].compact
      else
        flash[:notice] = "That didn't work out"
      end

      render :new
    end

    # @movie = Movie.create(movie_params)
    # redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :genre, :director, :poster, :plot, :reviews_attributes)
  end
end
