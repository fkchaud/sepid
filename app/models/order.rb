# Pedido
class Order < ApplicationRecord
  attribute :order_date, :date
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
    most_recent_date = order_status_histories.maximum("created_at")
    osh = order_status_histories.find_by_created_at(most_recent_date)
    osh.order_status
  end

  def order_expenses
    total_expenses_per_subsection = {}
    total_expenses_per_subsection.default = 0.0
    details = self.order_details
    details.each do |detail|
      total_expenses_per_subsection[detail.subsection] += detail.last_value.amount
    end
    total_expenses_per_subsection
  end
end
