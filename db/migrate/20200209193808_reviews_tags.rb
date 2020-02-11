class ReviewsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews_tags do |t|
      t.integer :review_id
      t.integer :tag_id
    end
  end
end
