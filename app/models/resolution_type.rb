# TipoResolucion
class ResolutionType < ApplicationRecord
  validates :name, presence: true

  scope :enabled, -> { where(is_disabled: nil) }

  has_many :funds_resolutions
end
