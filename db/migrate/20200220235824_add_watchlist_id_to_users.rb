class AddWatchlistIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :watchlist_id, :integer
  end
end
