# HistorialEstadoCambioInciso
class SubsectionShiftStatusHistory < ApplicationRecord
  # attributes
  attribute :date, :datetime

  # validations
  validates :date, uniqueness: true

  # relationships
  belongs_to :subsection_shift_status
  belongs_to :subsection_shift
end
