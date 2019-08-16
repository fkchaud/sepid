# EstadoProyecto
class ProjectStatus < ApplicationRecord
  validates :name, presence: true

  has_many :projects
end
