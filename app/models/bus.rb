
class Bus < ApplicationRecord
    has_many :seats, dependent: :destroy
    has_many :bookings, through: :seats , dependent: :destroy # Assuming bookings are associated with seats

    belongs_to :user
    enum bus_type: [:Ac , :NonAc]
  
    validates :bus_name, presence: true
    validates :bus_number, presence: true
    validates :bus_type, presence: true
    validates :price_of_a_single_seat, presence: true
    validates :departure_time, presence: true
    validates :departure_location, presence: true
    validates :arrival_time, presence: true
    validates :arrival_location, presence: true
  
    after_create :create_default_seats
  
    private
  
    def create_default_seats
      number_of_seats.times do |i|
        seats.create(seat_number: i + 1)
      end
    end
  end
  