require 'faker'

# Clear existing data
Bus.destroy_all
Seat.destroy_all
User.destroy_all

# Create a sample user
user = User.create!(
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password',
  name: Faker::Name.name,
  contact: Faker::PhoneNumber.cell_phone,
  role: 0
)

# Create sample buses and seats
10.times do
  bus = Bus.create!(
    bus_name: Faker::Vehicle.make_and_model,
    bus_number: Faker::Vehicle.license_plate,
    bus_type: 0,
    price_of_a_single_seat: rand(50..200),
    departure_time: Faker::Time.forward(days: 23, period: :morning),
    departure_location: Faker::Address.city,
    arrival_time: Faker::Time.forward(days: 23, period: :afternoon),
    arrival_location: Faker::Address.city,
    user: user,
    number_of_seats: 20
  )
  

#   bus.number_of_seats.times do |i|
#     Seat.create!(
#       bus: bus,
#       seat_number: i + 1
#     )
#   end
end

puts "Seed data created successfully!"
