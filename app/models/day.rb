class Day < ApplicationRecord
  belongs_to :trip

  validates :date, presence: true
end
