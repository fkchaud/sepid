class Order < ApplicationRecord
  validates :order_date, presence: true
  validates :description_order, presence: true
  validates :reason_order, presence: true

  has_one :order_type
  has_one :project
  has_many :value_attribute_type_orders
  has_many :order_status_histories
  has_many :order_details
end
