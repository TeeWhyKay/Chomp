require 'sidekiq/api'
class ChompsessionCancellationJob < ApplicationJob
  queue_as :default

  def perform(chomp_session_id)
    Sidekiq::ScheduledSet.new.find_job(ChompSession.find(chomp_session_id).sidekiq_jid).try(:delete)
  end
end
