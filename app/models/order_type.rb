# TipoPedido
class OrderType < ApplicationRecord
  validates :name_type_order, presence: true

  has_many :orders
  has_many :order_detail_attributes
  has_many :order_type_attributes

  scope :enabled, -> { where(is_disabled: nil) }
end
