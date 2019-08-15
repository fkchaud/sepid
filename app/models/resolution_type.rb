class ResolutionType < ApplicationRecord
  validates :name, presence: true
  # has many funds_resolutions
end
