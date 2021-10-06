class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :content, length: { maximum: 300 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
