class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :chomp_sessions
  has_one_attached :image
  validates :name, :address, presence: true
  geocoded_by :address,
              latitude: :fetched_latitude,
              longitude: :fetched_longitude
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, unless: ->(obj){ obj.address.present? and obj.latitude.present? and obj.longitude.present? }
end
