class OrderStatusesController < ApplicationController

  def index
    @order_statuses = OrderStatus.all
  end

  def create
    @order_status = OrderStatus.new order_status_params
    render 'new' unless @order_status.save
  end

  def new
    @order_status = OrderStatus.new
  end

  def edit
    @order_status = OrderStatus.find params[:id]
  end

  def show
    @order_status = OrderStatus.find params[:id]
  end

  def update
    @order_status = OrderStatus.find params[:id]
    render 'edit' unless @order_status.update order_status_params
  end

  def destroy
    @order_status = OrderStatus.find params[:id]
    @order_status.update is_disabled: Time.now
    redirect_to order_statuses_path
  end

  private

  def order_status_params
    params.require(:order_status).permit(:order_status_name,
                                         :order_status_description,
                                         :allow_cancel_order)
  end

end
