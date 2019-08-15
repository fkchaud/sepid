class OrderStatus < ApplicationRecord
  validates :allow_cancel_order, presence: true
  validates :order_status_description, presence: true
  validates :order_status_name, presence: true
end
