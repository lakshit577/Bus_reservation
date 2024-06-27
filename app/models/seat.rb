class Seat < ApplicationRecord
    belongs_to :bus
    has_one :reservation




    validates :seat_number, presence: true, uniqueness: { scope: :bus_id }
end
