class AddUserLimitToSession < ActiveRecord::Migration[6.0]
  def change
    add_column :chomp_sessions, :invitees, :integer
  end
end
