class WatchlistsController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @movies = @user.watchlist.movies
    else
      @user = current_user
      @movies = @user.watchlist.movies 
    end
  end

  def create
    @movie = Movie.find(params[:movie_id])
    update_or_create_watchlist
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @watchlist = Watchlist.find(params[:id])
    @watchlist.movies.delete(@movie)
    flash[:alert] = "movie deleted from watchlist"
    redirect_to movie_path @movie
  end


end
