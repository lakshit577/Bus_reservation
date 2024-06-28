class Bus < ApplicationRecord
    belongs_to :user
    has_many :seats , dependent: :destroy
    has_many :payments , dependent: :destroy

     # Validations
    validates :bus_name, presence: true
    validates :bus_number, presence: true, uniqueness: true
    validates :bus_type, presence: true
    validates :price_of_a_single_seat, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :departure_datetime, presence: true
    validates :departure_location, presence: true
    validates :arrival_datetime, presence: true
    validates :arrival_location, presence: true
    validates :user_id, presence: true
    validates :number_of_seats, presence: true, numericality: { greater_than: 0 } 


    enum bus_type: [:Ac , :NonAc]
    # accepts_nested_attributes_for :seats
end