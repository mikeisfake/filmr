class AddDefaultValueToColorMode < ActiveRecord::Migration[5.2]
  def change
    change_column :settings, :color_mode, :boolean, default: true
  end
end
