class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :chomp_sessions
  has_one_attached :image
  validates :name, :address, presence: true
end
