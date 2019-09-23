# DestinoFondos
class FundsDestination < ApplicationRecord
  # attributes
  attribute :name, :string
  attr_accessor :project_id

  # validations
  validates :name, presence: true
  validates :project_funds_details, presence: true
  validates_associated :project_funds_details

  has_many :project_funds_details, inverse_of: :funds_destination
  accepts_nested_attributes_for :project_funds_details, reject_if: :all_blank
  belongs_to :funds_resolution
end
