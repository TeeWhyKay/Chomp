class AddAverageRatingToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :average_rating, :float
  end
end
