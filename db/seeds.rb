require "open-uri"

User.destroy_all

user1 = User.create!(
  email: "bgdu33@gmail.com",
  password: "123456",
  pseudo: "Jijou",
  address: "1452 Rue Bélanger, Montréal, QC H2G 1A7"
)
