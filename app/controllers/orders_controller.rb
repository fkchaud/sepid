class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order.order_date = Time.now.strftime("%d/%m/%Y")
  end
end
