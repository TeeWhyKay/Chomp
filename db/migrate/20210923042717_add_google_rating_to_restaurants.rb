class AddGoogleRatingToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :google_rating, :float
  end
end
