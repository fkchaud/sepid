class ValueAttributeTypeOrder < ApplicationRecord

  belongs_to :order_type_attribute
  has_one :order
end
