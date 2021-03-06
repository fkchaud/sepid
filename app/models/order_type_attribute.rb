# AtributoTipoPedido
class OrderTypeAttribute < ApplicationRecord
  validates :attribute_name, presence: true
  validates :attribute_type, presence: true

  belongs_to :order_type
  has_many :order_type_attribute_values
end
