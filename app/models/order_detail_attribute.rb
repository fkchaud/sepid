class OrderDetailAttribute < ApplicationRecord
  validates :attribute_name, presence: true
  validates :attribute_type, presence: true

  belongs_to :order_type
  has_many :order_detail_attribute_values
end
