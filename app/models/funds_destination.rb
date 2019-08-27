# DestinoFondos
class FundsDestination < ApplicationRecord
  # attributes
  attribute :name, :string

  # validations
  validates :name, presence: true

  has_many :project_funds_details, inverse_of: :funds_destination
  accepts_nested_attributes_for :project_funds_details, reject_if: :all_blank
  belongs_to :funds_resolution
end
