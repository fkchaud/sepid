class Order < ApplicationRecord
  validates :order_date, presence: true
  validates :description_order, presence: true
  validates :reason_order, presence: true
end
