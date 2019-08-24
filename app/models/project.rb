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
  validate :ending_date_after_start_date, on: :create

  def ending_date_after_start_date
    if start_date.present? &&
       ending_date.present? &&
       start_date >= ending_date
      errors.add(:start_date, "can't be after end date")
      errors.add(:ending_date, "can't be before start date")
    end
  end

  def disabled?
    project_status.name == 'Cancelado' || project_status.name == 'Finalizado'
  end

end
