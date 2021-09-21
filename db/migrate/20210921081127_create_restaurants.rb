class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longtitude
      t.datetime :opening_time
      t.datetime :closing_time

      t.timestamps
    end
  end
end
