class OrderTypeAttribute < ApplicationRecord
  validates :attribute_name, presence: true
  validates :type_attribute, presence: true

  has_one :order_type
end
