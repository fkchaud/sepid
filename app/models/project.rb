# Proyecto
class Project < ApplicationRecord
  validates :project_code, presence: true
  validates :project_name, presence: true
  validates :start_date, presence: true
  validates :ending_date, presence: true

  has_one :project_status
  has_one :project_type
  # TODO: testear si andan estos dos
  has_one :director,
          class_name: 'User',
          inverse_of: :projects_as_director
  has_one :codirector,
          class_name: 'User',
          inverse_of: :projects_as_codirector
  has_many :project_funds_details
  has_many :orders, optional: true
end
