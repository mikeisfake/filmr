class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.boolean :color_mode

      t.timestamps
    end
  end
end
