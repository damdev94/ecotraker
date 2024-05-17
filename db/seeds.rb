require "open-uri"

User.destroy_all

user1 = User.create(email: "bgdu33@gmail.com", password: 123456,pseudo: "Jijou", address: "1452 Rue Bélanger, Montréal, QC H2G 1A7")
vehicle1 = Vehicle.new(brand: "Toyota", model: "Corolla", year: "2022")
vehicle1.user = user1
vehicle1.save
trip1 = Trip.new(start: "1452 Rue Bélanger, Montréal, QC H2G 1A7", end: "2657 Rue Ontario E, Montréal, QC H2K 1X1", label: "Work")
trip1.user = user1
trip1.vehicle = vehicle1
trip1.save
