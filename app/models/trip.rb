class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days, allow_destroy: true

  validates :start, :end, :label, :vehicle, presence: true
  validate :start_must_be_different_from_end

  private

  def start_must_be_different_from_end
    if start == self.end
      errors.add(:end, "must be different form start")
    end
  end
end
