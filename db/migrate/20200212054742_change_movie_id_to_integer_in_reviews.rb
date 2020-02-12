class ChangeMovieIdToIntegerInReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :movie_id, :integer
  end
end
