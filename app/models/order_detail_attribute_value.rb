# ValorAtributoDetallePedido
class OrderDetailAttributeValue < ApplicationRecord
  validates :value, presence: true
  belongs_to :order_detail_attribute
  belongs_to :order_detail
end
