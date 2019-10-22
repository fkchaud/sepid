class MyDataMethods
  def self.orders_by_type(properties)
    Order.joins(:order_type).group('order_types.name_type_order').order('order_types.name_type_order').count
  end
  def self.orders_by_status(properties)
    Order.joins(order_status_histories: [:order_status]).group('order_statuses.order_status_name').order('order_statuses.order_status_name').count
  end
end