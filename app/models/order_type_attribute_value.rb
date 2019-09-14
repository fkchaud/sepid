# ValorAtributoTipoPedido
class OrderTypeAttributeValue < ApplicationRecord
  validates :value, presence: true
  belongs_to :order_type_attribute
  belongs_to :order
end
