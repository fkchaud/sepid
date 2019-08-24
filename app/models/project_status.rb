# EstadoProyecto
class ProjectStatus < ApplicationRecord
  attribute :name, :string
  validates :name, presence: true
  attribute :description, :string
  attribute :is_disabled, :datetime, default: nil

  scope :enabled, -> { where(is_disabled: nil) }

  has_many :projects
end
