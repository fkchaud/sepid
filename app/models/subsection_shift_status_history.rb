# HistorialEstadoCambioInciso
class SubsectionShiftStatusHistory < ApplicationRecord
  validates :date, uniqueness: true

  belongs_to :subsection_shift_status
  belongs_to :subsection_shift
end
