class ChompSession < ApplicationRecord
  # after_create :send_create_email

  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, :time, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24

  # private

  # def send_create_email
  #   ChompSessionMailer.with(chomp_session: self).create_confirmation.deliver_now
  # end
end
