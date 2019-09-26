class OrderTypeAttributesController < ApplicationController

  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = @order_type.order_type_attributes.create(order_type_attribute_params)
    redirect_to order_type_path(@order_type)
  end

  def edit
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = @order_type.order_type_attributes.find(params[:id])
    if @order_type_attribute.is_disabled
      flash[:error] = 'No se puede editar un atributo del pedido dado de baja'
      redirect_to order_type_path(@order_type)
      return
    end
  end

  def update
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = @order_type.order_type_attributes.find(params[:id])
    @order_type_attribute.update(order_type_attribute_params)
    redirect_to order_type_path(@order_type)
  end

  def destroy
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = @order_type.order_type_attributes.find(params[:id])
    @order_type_attribute.update(is_disabled: Time.now)
    redirect_to order_type_path(@order_type)
  end

  private

  def order_type_attribute_params
    params.require(:order_type_attribute).permit(:attribute_name, :attribute_type)
  end
end
