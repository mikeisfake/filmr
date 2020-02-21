class WatchlistsController < ApplicationController

  def create

    @movie = Movie.find(params[:movie_id])
    if current_user.watchlist.nil?
      @watchlist = Watchlist.new
      current_user.watchlist = @watchlist
      @watchlist.movies << @movie
      if @watchlist.save
        redirect_to movie_path(@movie)
      end
    else
      if !current_user.watchlist.movies.include?(@movie)
        current_user.watchlist.movies << @movie
        redirect_to movie_path(@movie)
      end
    end
  end


end
