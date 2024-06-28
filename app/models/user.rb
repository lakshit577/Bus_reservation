class User < ApplicationRecord

    has_many :buses, dependent: :destroy
    has_many :reservations
    has_many :seat_reservations

    # Validations
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :contact, presence: true, length: { minimum: 10, maximum: 15 }
  

  enum role: [:customer, :bus_owner]
  # after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end