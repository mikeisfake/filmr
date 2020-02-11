class RenameReviewsTagsToReviewTags < ActiveRecord::Migration[5.2]
  def change
    rename_table :reviews_tags, :review_tags 
  end
end
