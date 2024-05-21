class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  belongs_to :end_place, foreign_key: "end_place_id", class_name: "Place"
  belongs_to :start_place, foreign_key: "start_place_id", class_name: "Place"
  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true

  validates  :label, :vehicle, presence: true

end
