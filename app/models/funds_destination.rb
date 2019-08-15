# DestinoFondos
class FundsDestination < ApplicationRecord
  validates :name, presence: true


  has_many :project_funds_details
  belongs_to :funds_resolution
end
