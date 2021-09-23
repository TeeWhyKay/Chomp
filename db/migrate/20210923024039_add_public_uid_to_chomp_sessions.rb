class AddPublicUidToChompSessions < ActiveRecord::Migration[6.0]
  def change
    rename_column :chomp_sessions, :unique_identifier, :public_uid
    add_index  :chomp_sessions, :public_uid, unique: true
  end
end
