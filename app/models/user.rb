class User < ApplicationRecord
  has_many :bookings
  has_many :seats, through: :bookings
  has_many :buses
  enum role: [:customer, :bus_owner]
  # after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end