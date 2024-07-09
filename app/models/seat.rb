class Seat < ApplicationRecord
  belongs_to :bus
  has_many :bookings , dependent: :destroy
  has_many :users, through: :bookings , dependent: :destroy

  # belongs_to :bus
  validates :seat_number, presence: true, uniqueness: { scope: :bus_id }

  def available?(date)
    bookings.none? { |booking| booking.booking_date == date }
  end
end
