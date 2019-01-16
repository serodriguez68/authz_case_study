class Client < ApplicationRecord
  belongs_to :user
  has_many :services
  has_many :cities, through: :services

  validates :name, presence: true
  validates :user_id, uniqueness: true

  delegate :email, to: :user, prefix: true

end
