class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :seat

  validates :booking_date, presence: true
  validate :validate_booking_date_and_seat, on: :create
  private

  def validate_booking_date_and_seat
    if Booking.exists?(seat_id: seat_id, booking_date: booking_date)
      errors.add(:base, "This seat has already been booked for the selected date.")
    end
  end
end