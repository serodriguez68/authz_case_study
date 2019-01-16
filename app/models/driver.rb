class Driver < ApplicationRecord
  belongs_to :user
  has_many :services
  has_many :cities, through: :services

  validates :name, presence: true
  validates :user_id, uniqueness: true

  delegate :email, to: :user, prefix: true

  # FIXME: this is a dummy solution for the sake of the example
  scope :available, -> { Driver.all }
end
