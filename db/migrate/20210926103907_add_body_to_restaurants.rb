class AddBodyToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :body, :text
  end
end
