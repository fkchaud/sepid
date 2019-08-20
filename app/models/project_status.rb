# EstadoProyecto
class ProjectStatus < ApplicationRecord
  attribute :name, :string
  validates :name, presence: true
  attribute :description, :string
  attribute :is_disabled, :datetime, default: nil

  has_many :projects
end
