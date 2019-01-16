class StaffMember < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  delegate :email, to: :user, prefix: true

end
