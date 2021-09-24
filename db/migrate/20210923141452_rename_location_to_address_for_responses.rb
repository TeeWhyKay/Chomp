class RenameLocationToAddressForResponses < ActiveRecord::Migration[6.0]
  def change
    rename_column :responses, :location, :address
  end
end
