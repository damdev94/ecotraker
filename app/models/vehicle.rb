class Vehicle < ApplicationRecord
  belongs_to :user

  validates :brand, :model, :year, precence: true
end
