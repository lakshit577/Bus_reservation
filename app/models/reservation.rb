class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :bus
  belongs_to :seat

  # validates :price, presence: true, numericality: { greater_than: 0 }
end
