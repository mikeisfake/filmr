class WatchlistsController < ApplicationController
  before_action: :authenticate_user!
  before_action: :set_user
  before_action: :set_watchlist
  def index
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = current_user
  end

  def set_watchlist
    @watchlist = current_user.watchlist 
  end

end
