class Payment < ApplicationRecord
    belongs_to :bus
  belongs_to :user

  validates :seat_ids, presence: true
  validates :no_of_selected_seats, presence: true
  validates :selected_seat_numbers, presence: true
  validates :total_amount, presence: true
  validates :paid, inclusion: { in: [true, false] }
end
