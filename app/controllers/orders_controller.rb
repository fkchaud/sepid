class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    render plain: params[:order].inspect

  end
  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @subsections = Subsection.where(is_disabled: nil)
    @order = Order.new
  end
end
