# DetallePedido
class OrderDetail < ApplicationRecord
  validates :description_detail, presence: true

  belongs_to :order
  belongs_to :subsection
  has_many :value_histories
  has_many :order_detail_attribute_values
  accepts_nested_attributes_for :order_detail_attribute_values

  def last_value
    most_recent_date = value_histories.maximum("date")
    value_histories.find_by_date(most_recent_date)
  end
end
