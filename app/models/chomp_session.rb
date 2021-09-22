class ChompSession < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, :time, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24
end
