class ValueHistory < ApplicationRecord
  validates :amount, presence: true
  validates :description, presence: true
  validates :date, presence: true

  has_one :value_status
  belongs_to :order_detail
end
