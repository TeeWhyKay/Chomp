class ChompSession < ApplicationRecord
  UID_RANGE = 111_111..999_999
  generate_public_uid generator: PublicUid::Generators::NumberRandom.new(UID_RANGE)

  def self.find_puid(param)
    find_by public_uid: param.split('-').first
  end

  def to_param
    "#{public_uid}"
  end

  belongs_to :user
  belongs_to :restaurant, optional: true
  has_many :responses, dependent: :destroy
  validates :name, :date, :time, presence: true
  validate :date_cannot_be_in_the_past, :time_cannot_be_in_the_past, :invitees_optional, :expiry_time_validation
  attribute :status, :string, default: "pending"
  attribute :session_expiry, :integer, default: 24

  def date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

  def time_cannot_be_in_the_past
    if date == Date.today && time.strftime("%H:%M").to_time < Time.now.strftime("%H:%M").to_time
      errors.add(:time, "can't be in the past")
    end
  end

  def invitees_optional
    if invitees.to_i <= 0 && !invitees.nil?
      errors.add(:invitees, "must be more than 1")
    end
  end

  def expiry_time_validation
    meeting_date = "#{date.strftime("%Y-%m-%d")} #{time.strftime("%H:%M")}".to_time
    if meeting_date - Time.now < (session_expiry * 3600)
      errors.add(:session_expiry, "is after the meeting time")
    end
  end
end
