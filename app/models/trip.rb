class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  belongs_to :end_place, class_name: "Place"
  belongs_to :start_place, class_name: "Place"

  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true

  validates  :label, :vehicle, presence: true

  attr_accessor :schedule

end
