class OrderDetail < ApplicationRecord
  validates :description_detail, presence: true
end
