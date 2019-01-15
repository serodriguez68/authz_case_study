class Client < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :user_id, uniqueness: true

end
