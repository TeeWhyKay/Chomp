class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor
  after_create :send_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :reviews
  has_many :chomp_sessions, dependent: :destroy

  def send_email
    UserMailer.with(user: self).welcome.deliver_later
  end
end
