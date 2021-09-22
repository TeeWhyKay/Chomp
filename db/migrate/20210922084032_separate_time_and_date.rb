class SeparateTimeAndDate < ActiveRecord::Migration[6.0]
  def change
    change_column :chomp_sessions, :date, :date
    add_column :chomp_sessions, :time, :time
  end
end
