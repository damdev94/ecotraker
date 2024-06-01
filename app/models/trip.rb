class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  belongs_to :end_place, class_name: "Place"
  belongs_to :start_place, class_name: "Place"
  before_save :calculate_distance

  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true

  validates  :label, :vehicle, presence: true

  attr_accessor :schedule

  def calculate_distance
    self.distance = Geocoder::Calculations.distance_between([self.start_place.latitude,self.start_place.longitude],[self.end_place.latitude,self.end_place.longitude])
  end


end
