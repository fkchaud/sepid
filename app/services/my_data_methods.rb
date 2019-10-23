class MyDataMethods
  def self.orders_by_type(properties)
    Order.joins(:order_type).group('orders.order_date', 'order_types.name_type_order').order('orders.order_date').count
  end
  def self.change_status_count(properties)
    OrderStatusHistory.joins(:order_status).group('order_status_histories.date_change_status_order', 'order_statuses.order_status_name').order('order_status_histories.date_change_status_order').count
  end
end