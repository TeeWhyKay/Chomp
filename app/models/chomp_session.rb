class ChompSession < ApplicationRecord
  UID_RANGE = 111_111..999_999
  generate_public_uid generator: PublicUid::Generators::NumberRandom.new(UID_RANGE)
  
  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, :time, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24

end
