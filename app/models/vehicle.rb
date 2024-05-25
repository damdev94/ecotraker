class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :trips, dependent: :destroy

  validates :brand, :model, :year, presence: true, if: :car?

  private

  def car?
    vehicle_type == "car"
  end
end
