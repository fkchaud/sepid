# CargoUniversitario
class UniversityPosition < ApplicationRecord
  attribute :name, :string
  validates :name, presence: true
  attribute :per_lunch_payment, :decimal
  validates :per_lunch_payment, numericality: { greater_than_or_equal_to: 0 }
  attribute :per_travel_payment, :decimal
  validates :per_travel_payment, numericality: { greater_than_or_equal_to: 0 }
  attribute :is_disabled, :datetime, default: nil

  has_many :users

end