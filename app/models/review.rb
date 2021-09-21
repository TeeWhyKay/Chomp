class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :title, length: { in: 3..30 }
  validates :content, length: { in: 5..300 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 2 }
end
