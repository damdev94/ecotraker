require "open-uri"

User.destroy_all

user1 = User.create!(
  email: "bgdu33@gmail.com",
  password: "123456",
  pseudo: "Jijou",
  address: "1452 Rue Bélanger, Montréal, QC H2G 1A7"
)

vehicle1 = Vehicle.create!(
  vehicle_type: "car",
  brand: "Toyota",
  model: "Corolla",
  year: "2022",
  user: user1
)

vehicle2 = Vehicle.create!(
  vehicle_type: "bus",
  user: user1
)

place1 = Place.create!(
  id: 1,
  name: "work",
  address: "Ottawa",
  user: user1,
  latitude: 45.4208777,
  longitude: -75.6901106
)
place2 = Place.create!(
  id: 2,
  name: "loic jeannin",
  address: "Montréal",
  user: user1,
  latitude: 45.5031824,
  longitude: -73.5698065
)

trip1 = Trip.create!(
  start_place_id: place2.id,
  end_place_id: place1.id,
  label: "#{place2.name} to #{place1.name}",
  user: user1,
  vehicle: vehicle1
)

day1 = Day.create!(
  id:1,
  trip_id: trip1.id,
  date: Date.today
)

if trip1.save
  puts "Trip created successfully!"
else
  puts "Failed to create trip: #{trip1.errors.full_messages.join(", ")}"
end
