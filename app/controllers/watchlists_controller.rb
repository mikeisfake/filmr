class WatchlistsController < ApplicationController

  def create

    @movie = Movie.find(params[:movie_id])

    if current_user.watchlist.nil?
      @watchlist = Watchlist.create
      current_user.watchlist = @watchlist
      @watchlist.movies << @movie
    else
      @watchlist = current_user.watchlist
      @watchlist.movies << @movie
    end
    byebug 
  end


end
