# ValorAtributoTipoPedido
class OrderTypeAttributeValue < ApplicationRecord
  has_one :order_type_attribute
  belongs_to :order
end
