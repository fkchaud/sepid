# ValorAtributoDetallePedido
class OrderDetailAttributeValue < ApplicationRecord

  belongs_to :order_detail_attribute
  belongs_to :order_detail
end
