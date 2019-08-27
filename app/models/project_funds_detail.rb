# DetalleFondoProyecto
class ProjectFundsDetail < ApplicationRecord
  validates :funds_amount, presence: true
  validates :year,
            presence: true,
            numericality: { greater_than: 2000, less_than: 3000 }

  belongs_to :subsection
  belongs_to :funds_destination
  belongs_to :subsection_shift
  belongs_to :project
end
