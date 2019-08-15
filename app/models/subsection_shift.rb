# CambioInciso
class SubsectionShift < ApplicationRecord
  validates :requested_date, presence: true
  # has many DetalleFondoProyecto
  has_many :subsection_shift_status_histories
end
