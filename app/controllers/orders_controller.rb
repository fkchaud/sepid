class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    render plain: params[:order].inspect
    @order = Order.new
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:order][:project_id])
    @order_status =  OrderStatus.where(order_status_name:'Solicitado', is_disabled: nil).take
    @order.project = @project
    @order_status_history = @order.order_status_histories.new(date_change_status_order: Time.now,
                                                              reason_change_status_order:'Pedido iniciado')
    @order_status_history.order_status = @order_status
    @order.order_date = Time.now.strftime("%d/%m/%Y")

    end
  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @order = Order.new
  end
end
