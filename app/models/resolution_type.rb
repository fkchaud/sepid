# TipoResolucion
class ResolutionType < ApplicationRecord
  validates :name, presence: true

  has_many :funds_resolutions
end
