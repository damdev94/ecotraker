class Place < ApplicationRecord
  belongs_to :user

  has_many :start_trips, class_name: 'Trip', foreign_key: 'start_place_id'
  has_many :end_trips, class_name: 'Trip', foreign_key: 'end_place_id'

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
