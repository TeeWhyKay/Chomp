class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :budget
      t.string :location
      t.string :email
      t.string :cuisine
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true
      t.references :chomp_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
