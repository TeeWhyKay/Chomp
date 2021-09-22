class Response < ApplicationRecord
  belongs_to :user
  belongs_to :chompsession
  validates :budget, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 5 }
  validates :location, presence: true
  serialize :cuisine, Array

  collection = ["Western", "Chinese", "Malay", "Indonesian", "Japanese", "Korean", "Indian", "Spanish", "French", "Italian"]
end
