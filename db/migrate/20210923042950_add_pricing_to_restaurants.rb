class AddPricingToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :pricing, :integer
  end
end
