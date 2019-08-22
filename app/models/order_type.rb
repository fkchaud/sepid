# TipoPedido
class OrderType < ApplicationRecord
  validates :name_type_order, presence: true
  validates :description_type_order, presence: true

  has_many :orders
  has_many :order_detail_attributes
  has_many :order_type_attributes
  #accepts_nested_attributes_for :order_type_attributes, allow_destroy: true
  #accepts_nested_attributes_for :order_detail_attributes, allow_destroy: true
end
