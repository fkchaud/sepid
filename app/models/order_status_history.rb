class OrderStatusHistory < ApplicationRecord
  validates :date_change_status_order, presence: true
  validates :reason_change_status_order, presence: true
end
