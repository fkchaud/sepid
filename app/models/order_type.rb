class OrderType < ApplicationRecord
  validates :name_type_order, presence: true
  validates :descrption_type_order, presence: true

  has_many :attribute_detail_orders
  has_many :order_type_attributes
end
