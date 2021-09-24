class ChompSession < ApplicationRecord
  after_create :send_chomp_create_confirmation

  include PublicUid::ModelConcern
  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, :time, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24

  private

  def send_chomp_create_confirmation
    ChompSessionMailer.with(chomp_session: self).create_chomp.deliver_now
  end
end
