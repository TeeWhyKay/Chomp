class AddSidekiqJidToChompSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :chomp_sessions, :sidekiq_jid, :string
  end
end
