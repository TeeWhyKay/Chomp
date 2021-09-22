class AddPhotoUrlToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :photo_url, :string
  end
end
