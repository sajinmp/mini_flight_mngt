# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Seeding airline and flights
origin_dest = ['bangalore', 'chennai', 'delhi', 'mumbai', 'cochin']
seat_types = GlobalConfig.where(configurable_type: 'seat_types').order(:id)
5.times do 
  airline = Airline.create!(name: Faker::Name.name)
  seat_types.each do |seat_type|
    airline.seat_configs.create!(
      seat_type: seat_type.value,
      no_of_rows: Faker::Number.between(1, 10),
      seats_in_row: Faker::Number.between(1, 6),
      base_price: Faker::Number.number(3).to_f
    )
  end
  origin = origin_dest.sample
  airline.flights.create!(origin: origin, destination: (origin_dest - [origin]).sample)
end
