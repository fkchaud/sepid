# Proyecto
class Project < ApplicationRecord
  validates :project_code, presence: true
  validates :project_name, presence: true
  validates :start_date, presence: true
  validates :ending_date, presence: true

  has_one :project_status
  has_one :project_type
  # TODO: user, con director y codirector
  has_many :project_funds_details
  has_many :orders
end
