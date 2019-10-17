# DestinoFondos
class FundsDestination < ApplicationRecord
  # attributes
  attribute :name, :string
  attr_accessor :project_id

  # validations
  validates :name, presence: true
  validates :project_funds_details, presence: true
  validate :project_funds_details_positive

  has_many :project_funds_details, inverse_of: :funds_destination
  accepts_nested_attributes_for :project_funds_details, reject_if: :all_blank
  belongs_to :funds_resolution

  def project_funds_details_positive
    return if project_funds_details.none? { |pfd| pfd.funds_amount <= 0 }

    project_funds_details.each do |pfd|
      pfd.errors.add :funds_amount, 'must be positive' if pfd.funds_amount <= 0
    end
    errors.add :project_funds_details, 'must be positive'
  end

  validates_associated :project_funds_details
end
