# ValorAtributoDetallePedido
class OrderDetailAttributeValue < ApplicationRecord

  has_one :order_detail_attribute
  belongs_to :order_detail
end
