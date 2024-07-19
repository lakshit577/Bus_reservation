class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :bus

  validate :booking_date_cannot_be_in_the_past

  private

  def booking_date_cannot_be_in_the_past
    if booking_date.present? && booking_date < Date.today
      errors.add(:booking_date, "can't be in the past")
    end
  end
end
