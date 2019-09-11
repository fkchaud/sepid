# ValorAtributoTipoPedido
class OrderTypeAttributeValue < ApplicationRecord
  belongs_to :order_type_attribute
  belongs_to :order
end
