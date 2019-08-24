# TipoProyecto
class ProjectType < ApplicationRecord
  validates :name, presence: true

  scope :enabled, -> { where(is_disabled: nil) }

  has_many :projects
end
