class OrderDetailAttributesController < ApplicationController
  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute_exist = OrderDetailAttribute.where(attribute_name: params[:order_detail_attribute][:attribute_name],
                                                           attribute_type: params[:order_detail_attribute][:attribute_type],
                                                           order_type: @order_type).take
    unless @order_detail_attribute_exist.nil?
      if @order_detail_attribute_exist.is_disabled != nil
        flash[:error] = 'Los datos ingresados corresponden a un atirbuto dado de baja, favor de volver a habilitarlo en caso de querer utilizarlo'
      else
        flash[:error] = 'Ya existe un atributo igual en este tipo de pedido'
      end
      redirect_to order_type_path(@order_type)
      return
    end
    flash[:success] = 'Atributo creado con éxito'
    @order_detail_attribute = @order_type.order_detail_attributes.create(order_detail_attribute_params)
    redirect_to order_type_path(@order_type)
  end
  def edit
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
    if @order_detail_attribute.is_disabled
      flash[:error] = 'No se puede editar un atributo de detalle dado de baja'
      redirect_to order_type_path(@order_type)
      return
    end
  end
  def update 
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
    @order_detail_attribute_exist = OrderDetailAttribute.where(attribute_name: params[:order_detail_attribute][:attribute_name],
                                                               attribute_type: params[:order_detail_attribute][:attribute_type],
                                                               order_type: @order_type).take
    unless @order_detail_attribute_exist.nil?
      if @order_detail_attribute_exist.is_disabled != nil
        flash[:error] = 'Los datos ingresados corresponden a un atirbuto dado de baja, favor de volver a habilitarlo en caso de querer utilizarlo'
      else
        flash[:error] = 'Ya existe un atributo igual en este tipo de pedido'
      end
      redirect_to edit_order_type_order_detail_attribute_path(@order_type, @order_detail_attribute)
      return
    end
    flash[:success] = 'Atributo editado con éxito'
    @order_detail_attribute.update(order_detail_attribute_params)
  redirect_to order_type_path(@order_type)
  end
  def destroy
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = @order_type.order_detail_attributes.find(params[:id])
    @order_detail_attribute.update(is_disabled: Time.now)
    redirect_to order_type_path(@order_type)
  end
  def enable_attribute
    @order_type = OrderType.find(params[:order_type_id])
    @order_detail_attribute = OrderDetailAttribute.find(params[:order_detail_attribute_id])
    @order_detail_attribute.update(is_disabled: nil)
    flash[:success] = 'Atributo habilitado con éxito'
    redirect_to order_type_path(@order_type)
  end
  private
  def order_detail_attribute_params
    params.require(:order_detail_attribute).permit(:attribute_name, :attribute_type)
  end
end
