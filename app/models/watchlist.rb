class Watchlist < ApplicationRecord
  has_one :user
  has_many :movie_watchlists
  has_many :movies, through: :movie_watchlists
end
