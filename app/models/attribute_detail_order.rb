class AttributeDetailOrder < ApplicationRecord
  validates :attribute_name, presence: true
  validates :attribute_type, presence: true

  has_one :order_type
  has_many :value_attribute_detail_orders
end
