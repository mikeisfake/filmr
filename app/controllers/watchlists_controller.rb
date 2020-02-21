class WatchlistsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    if current_user.watchlist.nil?
      @watchlist = Watchlist.new
      current_user.watchlist = @watchlist
      @watchlist.movies << @movie
      if @watchlist.save
        flash[:notice] = "movie added to watchlist"
        redirect_to movie_path(@movie)
      end
    else
      if !current_user.watchlist.movies.include?(@movie)
        current_user.watchlist.movies << @movie
        flash[:notice] = "movie added to watchlist"
        redirect_to movie_path(@movie)
      end
    end
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @watchlist = Watchlist.find(params[:id])
    @watchlist.movies.delete(@movie)
    flash[:alert] = "movie deleted from watchlist"
    redirect_to movie_path @movie
  end


end
