class Seat < ApplicationRecord
  belongs_to :bus

  # belongs_to :bus
  validates :seat_number, presence: true, uniqueness: { scope: :bus_id }
end
