# EstadoCambioInciso
class SubsectionShiftStatus < ApplicationRecord
  validates :name, presence: true

  # has many historial estado cambio inciso
end
