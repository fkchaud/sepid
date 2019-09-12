# HistorialValor
class ValueHistory < ApplicationRecord
  validates :amount, presence: true
  validates :date, presence: true

  belongs_to :value_status
  belongs_to :order_detail
end
