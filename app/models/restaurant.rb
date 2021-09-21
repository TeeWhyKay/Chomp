class Restaurant < ApplicationRecord
  has_many :chomp_sessions
  validates :name, :address, presence: true
end
