class AddDescriptionToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :description, :text
  end
end
