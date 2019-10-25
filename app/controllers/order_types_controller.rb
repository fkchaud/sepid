class OrderTypesController < ApplicationController

  TYPES = ['Número entero', 'Número decimal', 'Texto', 'Mail', 'Confirmación', 'Fecha'].freeze

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
      flash[:success] = 'Tipo de Pedido creado con éxito.'
      redirect_to @order_type
    else
      render 'new'
    end
  end

  def update
    @order_type = OrderType.find(params[:id])
    if @order_type.update order_type_params
      flash[:success] = 'Tipo de Pedido actualizado con éxito.'
      redirect_to @order_type
    else
      render 'edit'
    end

  end

  def destroy
    @order_type = OrderType.find(params[:id])
    @order_type.update(is_disabled: Time.now)
    order_type_attributes = @order_type.order_type_attributes
    order_type_detail_attributes = @order_type.order_detail_attributes
    order_type_detail_attributes.each do |detail_attribute|
      detail_attribute.update(is_disabled: Time.now)
    end
    order_type_attributes.each do |attribute|
      attribute.update(is_disabled: Time.now)
    end

    redirect_to order_types_path
  end

  private

  def order_type_params
    params.require(:order_type)
          .permit(:name_type_order, :description_type_order)
  end

end