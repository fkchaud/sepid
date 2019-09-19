# Pedido
class Order < ApplicationRecord
  validates :order_date, presence: true
  validates :description_order, presence: true
  validates :reason_order, presence: true

  belongs_to :order_type
  belongs_to :project
  has_many :order_type_attribute_values
  has_many :order_status_histories
  has_many :order_details
  accepts_nested_attributes_for :order_details, allow_destroy: true

  def order_status
    most_recent_date = order_status_histories.maximum("date_change_status_order")
    osh = order_status_histories.find_by_date_change_status_order(most_recent_date)
    osh.order_status
  end
end
