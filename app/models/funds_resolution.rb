# ResolucionFondos
class FundsResolution < ApplicationRecord
  # attributes
  attribute :number, :string
  attribute :date, :date

  # validations
  validates :number,
            presence: true,
            uniqueness: true,
            format: { with: %r{\A\d+/\d{4}\z},
                      message: 'format should be #####/####' }
  validates :date, presence: true

  belongs_to :resolution_type
  has_many :funds_destinations, inverse_of: :funds_resolution
  accepts_nested_attributes_for :funds_destinations, reject_if: :all_blank
end
