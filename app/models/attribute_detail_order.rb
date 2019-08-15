class AttributeDetailOrder < ApplicationRecord
  validates :attribute_name, presence: true
  validates :attribute_type, presence: true

  has_one :order_type
end
