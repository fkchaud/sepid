# Proyecto
class Project < ApplicationRecord
  # attributes
  attribute :project_code, :string
  attribute :project_name, :string
  attribute :project_description, :string
  attribute :start_date, :date
  attribute :ending_date, :date
  attribute :technological_scientific_unit, :string
  attribute :project_program, :string
  attribute :activity_type, :string

  def disabled?
    project_status.name == 'Cancelado' || project_status.name == 'Finalizado'
  end

  # references
  belongs_to :project_status
  belongs_to :project_type
  belongs_to :director,
             class_name: 'User',
             inverse_of: :projects_as_director
  accepts_nested_attributes_for :director
  belongs_to :codirector,
             class_name: 'User',
             inverse_of: :projects_as_codirector
  accepts_nested_attributes_for :codirector
  has_many :project_funds_details
  has_many :orders

  # validations
  validates :project_code, presence: true
  validates :project_name, presence: true
  validates :start_date, presence: true
  validates_date :start_date
  validates :ending_date, presence: true
  validates_date :ending_date
  validate :same_director_and_codirector,
           :ending_date_after_start_date

  def ending_date_after_start_date
    if start_date.present? &&
       ending_date.present? &&
       start_date >= ending_date
      errors.add(:start_date, "can't be on or after End date")
      errors.add(:ending_date, "can't be on or before Start date")
    end
  end

  def same_director_and_codirector
    if director.present? &&
       codirector.present? &&
       director.id == codirector.id
      errors.add(:director_id, "can't be the same as Codirector")
      errors.add(:codirector_id, "can't be the same as Director")
    end
  end

  # scopes for query
  scope :has_director, ->(user) { where(director: user).or(where(codirector: user)) }
  scope :actual_year, lambda {
    where(
      'extract(year from start_date) <= :year AND extract(year from ending_date) >= :year',
      year: Time.now.year
    )
  }
  scope :enabled, -> { where.not(project_status: ProjectStatus.find_by_name('Cancelado')) }

  # calculate money
  def total_credits(year = nil)
    year = Time.now.year if year.nil?
    project_funds_details = self.project_funds_details.where year: year
    total_credits_per_subsection = {}
    total_credits_per_subsection.default = 0.0
    project_funds_details.each do |pfd|
      next if pfd.subsection_shift && pfd.subsection_shift.last_status.name != 'Aprobado'

      total_credits_per_subsection[pfd.subsection] += pfd.funds_amount
    end
    total_credits_per_subsection
  end

  def total_expenses(year = nil)
    year = Time.now.year if year.nil?
    orders = self.orders.where('extract(year from order_date) = ?', year)
    valid_orders = orders.reject do |o|
      ['Pedido cancelado', 'Pedido rechazado'].include? o.order_status.order_status_name
    end
    total_expenses_per_subsection = {}
    total_expenses_per_subsection.default = 0.0
    return total_expenses_per_subsection if valid_orders.empty?

    valid_orders.each do |valid_order|
      order_details = valid_order.order_details
      order_details.each do |od|
        total_expenses_per_subsection[od.subsection] += od.last_value.amount
      end
    end
    total_expenses_per_subsection
  end

  def available_credits(credits = nil, expenses = nil, year = nil)
    year = Time.now.year if year.nil?
    credits = self.total_credits(year) if credits.nil?
    expenses = self.total_expenses(year) if expenses.nil?

    available_credits = {}
    available_credits.default = 0.0
    credits.each_key { |key| available_credits[key] = credits[key] - expenses[key] }
    available_credits
  end

end
