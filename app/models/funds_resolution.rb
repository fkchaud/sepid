class FundsResolution < ApplicationRecord
  validates :number,
            presence: true,
            uniqueness: true,
            format: { with: %r{^\d+/\d{4}$},
                      message: 'format should be #####/####' }
  validates :date, presence: true

  has_one :resolution_type
  # has many :funds_destinations (DestinoFondos)
end