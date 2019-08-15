class ValueAttributeDetailOrder < ApplicationRecord

  has_one :attribute_detail_order
  belongs_to :order_detail
end
