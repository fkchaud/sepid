# DetalleFondoProyecto
class ProjectFundsDetail < ApplicationRecord
  # attributes
  attribute :funds_amount, :float
  attribute :year, :integer

  # validations
  validates :funds_amount, presence: true
  validates :year,
            presence: true,
            numericality: { greater_than: 2000, less_than: 3000 }

  # relationships
  belongs_to :subsection
  belongs_to :funds_destination, optional: true
  belongs_to :subsection_shift, optional: true
  belongs_to :project
end
