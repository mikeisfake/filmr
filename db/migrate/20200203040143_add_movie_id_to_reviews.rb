class AddMovieIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :movie_id, :string
  end
end
