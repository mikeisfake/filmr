class WatchlistsController < ApplicationController

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
