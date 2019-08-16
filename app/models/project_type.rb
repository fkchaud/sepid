# TipoProyecto
class ProjectType < ApplicationRecord
  validates :name, presence: true

  has_many :projects
end
