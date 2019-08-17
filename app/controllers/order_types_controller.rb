class OrderTypesController < ApplicationController
  def index
    @order_types = OrderType.all
  end
  def show
    @order_type = OrderType.find(params[:id])
  end
  def new
  end
  def create
    @order_type = OrderType.new(order_type_params)
    if @order_type.save!
      redirect_to @order_type
    else
      render 'new'
    end
  end
  private
  def order_type_params
    params.require(:order_type).permit(:name_type_order, :description_type_order)
  end

end
