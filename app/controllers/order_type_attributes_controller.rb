class OrderTypeAttributesController < ApplicationController

  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute_exist = OrderTypeAttribute.where(attribute_name: params[:order_type_attribute][:attribute_name],
                                                           attribute_type: params[:order_type_attribute][:attribute_type],
                                                           order_type: @order_type).take
    unless @order_type_attribute_exist.nil?
      if @order_type_attribute_exist.is_disabled != nil
        flash[:error] = 'Los datos ingresados corresponden a un atirbuto dado de baja, favor de volver a habilitarlo en caso de querer utilizarlo'
      else
        flash[:error] = 'Ya existe un atributo igual en este tipo de pedido'
      end
      redirect_to order_type_path(@order_type)
      return
    end
    flash[:success] = 'Atributo creado con éxito'
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
    @order_type_attribute_exist = OrderTypeAttribute.where(attribute_name: params[:order_type_attribute][:attribute_name],
                                                           attribute_type: params[:order_type_attribute][:attribute_type],
                                                           order_type: @order_type).take
    unless @order_type_attribute_exist.nil?
      if @order_type_attribute_exist.is_disabled != nil
        flash[:error] = 'Los datos ingresados corresponden a un atirbuto dado de baja, favor de volver a habilitarlo en caso de querer utilizarlo'
      else
        flash[:error] = 'Ya existe un atributo igual en este tipo de pedido'
      end
      redirect_to edit_order_type_order_type_attribute_path(@order_type, @order_type_attribute)
      return
    end
    flash[:success] = 'Atributo editado con éxito'
    @order_type_attribute.update(order_type_attribute_params)
    redirect_to order_type_path(@order_type)
  end

  def destroy
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = @order_type.order_type_attributes.find(params[:id])
    @order_type_attribute.update(is_disabled: Time.now)
    flash[:success] = 'Atributo dado de baja con éxito'
    redirect_to order_type_path(@order_type)
  end

  def enable_attribute
    @order_type = OrderType.find(params[:order_type_id])
    @order_type_attribute = OrderTypeAttribute.find(params[:order_type_attribute_id])
    @order_type_attribute.update(is_disabled: nil)
    flash[:success] = 'Atributo habilitado con éxito'
    redirect_to order_type_path(@order_type)
  end

  private

  def order_type_attribute_params
    params.require(:order_type_attribute).permit(:attribute_name, :attribute_type)
  end
end
