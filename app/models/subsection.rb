# Inciso
class Subsection < ApplicationRecord
  validates :name, presence: true

  has_many :project_funds_details
  has_many :order_details
end
