class Driver < ApplicationRecord
  belongs_to :user
  has_many :services

  validates :name, presence: true
  validates :user_id, uniqueness: true

  delegate :email, to: :user, prefix: true

  # TODO: this is a dummy solution for the sake of the example
  scope :available, -> { Driver.all }
end
