class RemoveEmailFromResponse < ActiveRecord::Migration[6.0]
  def change
    remove_column :responses, :email
  end
end
