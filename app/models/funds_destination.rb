# DestinoFondos
class FundsDestination < ApplicationRecord
  # attributes
  attribute :name, :string

  # validations
  validates :name, presence: true

  has_many :project_funds_details
  belongs_to :funds_resolution
end
