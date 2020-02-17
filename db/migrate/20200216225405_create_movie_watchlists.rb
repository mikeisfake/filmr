class CreateMovieWatchlists < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_watchlists do |t|
      t.integer :movie_id
      t.integer :watchlist_id
    end
  end
end
