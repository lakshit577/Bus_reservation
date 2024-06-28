class Seat < ApplicationRecord
    belongs_to :bus
    # has_one :reservation
    # has_one :seat_reservation
    # has_one :user ,through: :seat_reservation
    belongs_to :user, optional: true





    validates :seat_number, presence: true, uniqueness: { scope: :bus_id }
end
