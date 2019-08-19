class OrderTypesController < ApplicationController

  def index
    @order_types = OrderType.all
  end

  def show
    @order_type = OrderType.find(params[:id])
  end

  def new
    @order_type = OrderType.new
  end

  def edit
    @order_type = OrderType.find(params[:id])
  end

  def create
    @order_type = OrderType.new(order_type_params)
    if @order_type.save
      redirect_to @order_type
    else
      render 'new'
    end
  end

  def update
    @order_type = OrderType.find(params[:id])
    if @order_type.update(order_type_params)
      redirect_to @order_type
    else
      render 'edit'
    end
  end

  def destroy
    @order_type = OrderType.find(params[:id])
    @order_type.update(is_disabled: Time.now)
    redirect_to order_types_path
  end

  private

  def order_type_params
    params.require(:order_type)
          .permit(:name_type_order, :description_type_order)
  end

end