class Bus < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :bookings, through: :seats, dependent: :destroy # Assuming bookings are associated with seats

  belongs_to :user
  enum bus_type: [:Ac, :NonAc]

  validates :bus_name, presence: true
  validates :bus_number, presence: true, format: { with: /\A\d{4}\z/, message: "must be of four-digit" }, if: -> { bus_number.present? }
  validates :bus_type, presence: true
  
  validates :price_of_a_single_seat, presence: true
  validates :price_of_a_single_seat, numericality: { greater_than: 0 }, if: -> { price_of_a_single_seat.present? }
  validates :price_of_a_single_seat, numericality: { less_than: 10_000_000 }, if: -> { price_of_a_single_seat.present? }
  validates :number_of_seats, presence: true
  validates :number_of_seats, numericality: { greater_than: 0 }, if: -> { number_of_seats.present? }
  validates :number_of_seats, numericality: { less_than: 101 }, if: -> { number_of_seats.present? }
  #if: -> { price_of_a_single_seat.present? }
  validates :departure_time, presence: true
  validates :departure_location, presence: true
  validates :arrival_time, presence: true
  validates :arrival_location, presence: true
  validate :departure_and_arrival_locations_cannot_be_same

  after_create :create_default_seats

  private

  def create_default_seats
    number_of_seats.times do |i|
      seats.create(seat_number: i + 1)
    end
  end

  def departure_and_arrival_locations_cannot_be_same
    if departure_location == arrival_location
      errors.add(:arrival_location, "cannot be the same as the departure location")
    end
  end
end
