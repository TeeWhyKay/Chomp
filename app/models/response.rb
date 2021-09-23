class Response < ApplicationRecord
  belongs_to :user
  belongs_to :chompsession
  validates :budget, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :location, presence: true
  geocoded_by :location,
              latitude: :fetched_latitude,
              longitude: :fetched_longitude
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, unless: ->(obj){ obj.latitude.present? and obj.longitude.present? }
end
