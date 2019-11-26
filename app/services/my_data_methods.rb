class MyDataMethods
  def self.orders_by_type(properties)
    ui_filters = properties[:ui_filters]
    orders = Order.joins(:order_type).group('orders.order_date', 'order_types.name_type_order').order('orders.order_date')
    orders = orders.where(order_date: ReportsKit.parse_date_range(ui_filters[:order_date])) if ui_filters[:order_date].present?
    orders.count
  end

  def self.change_status_count(properties)
    ui_filters = properties[:ui_filters]
    statuses = OrderStatusHistory.joins(:order_status).group('order_status_histories.date_change_status_order', 'order_statuses.order_status_name').order('order_status_histories.date_change_status_order')
    statuses = statuses.where(date_change_status_order: ReportsKit.parse_date_range(ui_filters[:date_change_status_order])) if ui_filters[:date_change_status_order].present?
    statuses.count
  end

  def self.orders_by_projects(properties)
    ui_filters = properties[:ui_filters]
    orders = Order.joins(:project).group('orders.order_date', 'projects.project_code').order('orders.order_date')
    orders = orders.where(order_date: ReportsKit.parse_date_range(ui_filters[:order_date])) if ui_filters[:order_date].present?
    orders.count
  end
end