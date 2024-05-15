class Trip < ApplicationRecord
  belongs_to :user
  has_many :days, dependent: :destroy

  validates :start, :end, :label , presence: true
  validate :start_must_be_different_from_end

  private

  def start_must_be_different_from_end
    if start == self.end
      errors.add(:end, "must be different form start")
    end
  end
end
