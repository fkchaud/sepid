# EstadoPedido
class OrderStatus < ApplicationRecord
  validates :allow_cancel_order, inclusion: { in: [true, false] },
                                 exclusion: { in: [nil] }
  validates :order_status_name, presence: true

  has_many :order_status_histories
end
