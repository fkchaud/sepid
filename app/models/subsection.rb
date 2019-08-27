# Inciso
class Subsection < ApplicationRecord
  validates :name, presence: true

  scope :enabled, -> { where(is_disabled: nil) }

  has_many :project_funds_details
  has_many :order_details
end
