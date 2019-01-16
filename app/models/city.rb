class City < ApplicationRecord
  has_many :services
  has_many :clients, through: :services
  has_many :drivers, through: :services
  validates :name, presence: true, uniqueness: true
end
