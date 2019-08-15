# HistorialEstadoCambioInciso
class SubsectionShiftStatusHistory < ApplicationRecord
  validates :date, uniqueness: true
  has_one :subsection_shift_status
  belongs_to :subsection_shift
end
