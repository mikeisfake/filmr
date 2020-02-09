class AddImdbidToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :imdbid, :string
  end
end
