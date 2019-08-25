class OrderDetailAttributesController < ApplicationController
  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.create(order_detail_attribute_params)
    redirect_to order_type_path(@order_type)
  end
  def edit
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
  end
  def update 
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
    @order_detail_attribute.update(order_detail_attribute_params)
  redirect_to order_type_path(@order_type)
  end
  def destroy
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
    @order_detail_attribute.update(is_disabled: Time.now)
    redirect_to order_type_path(@order_type)
  end
  private
  def order_detail_attribute_params
    params.require(:order_detail_attribute).permit(:attribute_name, :attribute_type)
  end
end
