# CambioInciso
class SubsectionShift < ApplicationRecord
  # attributes
  attribute :requested_date, :datetime
  attribute :requested_cause, :string

  # relationships
  has_many :project_funds_details
  accepts_nested_attributes_for :project_funds_details, reject_if: :all_blank
  has_many :subsection_shift_status_histories

  def last_status
    subsection_shift_status_histories.last.subsection_shift_status
  end

  # validations
  validates :requested_date, presence: true
  validates :requested_cause, presence: true
  validate :all_subsections_sum_zero

  def all_subsections_sum_zero
    suma = project_funds_details.sum { |pfd| pfd.funds_amount }
    if suma != 0
      project_funds_details.each do |pfd|
        pfd.errors.add :funds_amount, 'must sum 0'
      end
    end
  end
end
