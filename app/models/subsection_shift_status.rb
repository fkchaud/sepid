# EstadoCambioInciso
class SubsectionShiftStatus < ApplicationRecord
  validates :name, presence: true
  has_many :subsection_shift_status_histories
end
