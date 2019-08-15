class UniversityPosition < ApplicationRecord
  validates :name, presence: true
  validates :per_lunch_payment, numericality: { greater_than_or_equal_to: 0 }
  validates :per_travel_payment, numericality: { greater_than_or_equal_to: 0 }
end
