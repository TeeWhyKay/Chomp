class RenameColumnRestaurant < ActiveRecord::Migration[6.0]
  def change
    rename_column :restaurants, :longtitude, :longitude
  end
end
