require "open-uri"
require "json"

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
    if self.vehicle.vehicle_type == "metro"
      self.distance = Geocoder::Calculations.distance_between([self.start_place.latitude,self.start_place.longitude],[self.end_place.latitude,self.end_place.longitude])
    else
      if self.vehicle.vehicle_type == "car" || self.vehicle.vehicle_type == "bus"
        profile = "mapbox/driving"
      elsif self.vehicle.vehicle_type == "bike"
        profile = "mapbox/cycling"
      elsif self.vehicle.vehicle_type == "walk"
        profile = "mapbox/walking"
      end
      coordinates = "#{self.start_place.longitude},#{self.start_place.latitude};#{self.end_place.longitude},#{self.end_place.latitude}"
      url = "https://api.mapbox.com/directions/v5/#{profile}/#{coordinates}?access_token=#{ENV["MAPBOX_API_KEY"]}&geometries=geojson"
      distance_serialized = URI.open(url).read
      distance = JSON.parse(distance_serialized)
      self.distance = distance["routes"][0]["distance"]/1000
    end
    # self.distance = Geocoder::Calculations.distance_between([self.start_place.latitude,self.start_place.longitude],[self.end_place.latitude,self.end_place.longitude])
  end


end
