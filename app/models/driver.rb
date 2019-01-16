class Driver < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :user_id, uniqueness: true

  delegate :email, to: :user, prefix: true
end
