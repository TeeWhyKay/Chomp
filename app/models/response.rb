class Response < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :chomp_session
  validates :budget, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :address, presence: true
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, unless: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  serialize :cuisine, Array
  collection = ["Asian", "Chinese", "Western", "Japanese", "Italian", "Halal", "Indian", "Thai", "Korean", "Local", "Steamboat", "Desserts"]
end
