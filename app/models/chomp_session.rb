class ChompSession < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 1440
end
