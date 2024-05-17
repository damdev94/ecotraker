class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :trips, dependent: :destroy

  validates :brand, :model, :year, presence: true
end
