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

         validates :name, presence: true
         validates :contact, presence: true
         validates :contact,  format: { with: /\A\d{10}\z/, message: "should be a 10-digit non negative number" }, if: -> { contact.present? }


end



