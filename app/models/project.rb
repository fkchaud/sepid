class Project < ApplicationRecord
  validates :activity_type, presence: true
  validates :ending_date, presence: true
  validates :project_code, presence: true
  validates :project_description, presence: true
  validates :project_name, presence: true
  validates :project_program, presence: true
  validates :start_date, presence: true
  validates :technological_scientific_unit, presence: true
end
