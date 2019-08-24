# Proyecto
class Project < ApplicationRecord
  attribute :project_code, :string
  validates :project_code, presence: true
  attribute :project_name, :string
  validates :project_name, presence: true
  attribute :project_description, :string
  attribute :start_date, :date
  validates :start_date, presence: true
  validates_date :start_date, before: -> { ending_date }
  attribute :ending_date, :date
  validates :ending_date, presence: true
  validates_date :ending_date, after: -> { start_date}
  attribute :technological_scientific_unit, :string
  attribute :project_program, :string
  attribute :activity_type, :string

  belongs_to :project_status
  belongs_to :project_type
  # TODO: testear si andan estos dos
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
end
