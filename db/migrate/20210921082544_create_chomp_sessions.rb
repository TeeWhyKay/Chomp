class CreateChompSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :chomp_sessions do |t|
      t.string :name
      t.datetime :date
      t.string :unique_identifier
      t.string :status
      t.integer :session_expiry
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.timestamps
    end
  end
end
