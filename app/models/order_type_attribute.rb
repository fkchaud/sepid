class OrderTypeAttribute < ApplicationRecord
  validates :attribute_name, presence: true
  validates :type_attribute, presence: true

  has_one :order_type
  has_many :value_attribute_type_orders
end
