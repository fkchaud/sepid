# CambioInciso
class SubsectionShift < ApplicationRecord
  validates :requested_date, presence: true
  has_many :project_funds_details
  has_many :subsection_shift_status_histories
end
