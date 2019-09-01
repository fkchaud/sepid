# HistorialEstadoPedido
class OrderStatusHistory < ApplicationRecord
  validates :date_change_status_order, presence: true

  belongs_to :order
  belongs_to :order_status
end
