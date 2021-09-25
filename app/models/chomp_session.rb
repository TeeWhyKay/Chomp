class ChompSession < ApplicationRecord
  UID_RANGE = 111_111..999_999
  generate_public_uid generator: PublicUid::Generators::NumberRandom.new(UID_RANGE)
  
  def self.find_puid(param)
    find_by! public_uid: param.split('-').first
  end

  def to_param
    "#{public_uid}"
  end

  belongs_to :user
  belongs_to :restaurant, optional: true
  validates :name, :date, :time, presence: true
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24
end
