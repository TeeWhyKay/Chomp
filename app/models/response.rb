class Response < ApplicationRecord
  belongs_to :user
  belongs_to :chomp_session
  validates :budget, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :location, presence: true
  serialize :cuisine, Array

collection = [ "Asian", "Chinese", "Western", "Japanese", "Italian", "Halal", "Indian", "Thai", "Korean", "Local", "Steamboat", "Desserts" ]
end
