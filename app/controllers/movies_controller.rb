class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def new
  end

  def create
    find_or_create_movie params[:imdbid] if params[:imdbid]
  end

end
