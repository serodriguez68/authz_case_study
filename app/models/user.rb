class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :client, dependent: :destroy
  has_one :driver, dependent: :destroy
  has_one :staff_member, dependent: :destroy
end
