class OrderDetailAttributesController < ApplicationController
  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.create(order_detail_attribute_params)
    redirect_to order_type_path(@order_type)
  end
  private
  def order_detail_attribute_params
    params.require(:order_detail_attribute).permit(:attribute_name, :attribute_type)
  end
end
