class AddWebsiteUrlToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :website, :string
  end
end
