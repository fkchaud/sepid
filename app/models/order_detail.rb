# DetallePedido
class OrderDetail < ApplicationRecord
  validates :description_detail, presence: true

  belongs_to :order
  has_one :subsection
  has_many :value_histories
  has_many :order_detail_attribute_values
end
