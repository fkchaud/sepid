class OrderTypesController < ApplicationController

  TYPES = %w[Integer Float String Boolean Date].freeze

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
    render 'new' unless @order_type.save
  end

  def update
    @order_type = OrderType.find(params[:id])
    render 'edit' unless @order_type.update(order_type_params)
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