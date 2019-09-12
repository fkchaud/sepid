class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    # render plain: params[:order].inspect
    # Crear el pedido
    @order = Order.new(order_params)
    # Setear la fecha del pedido
    @order.order_date = Time.now.strftime('%m/%d/%Y')
    # Asociarle proyecto
    @order.project = Project.find(params[:order][:project_id])
    # Buscar el tipo de pedido seleccionado
    @order_type = OrderType.find(params[:order][:order_type_id])
    # Validar el pedido
    unless @order.valid?
      # Mandar mensaje de error y redireccionar
    end
    (0...(@order_type.order_type_attributes.length)).each do |index|
      @current_order_attribute = @order.order_type_attribute_values.new(value: params[:order][:attribute_names][index])
      unless @current_order_attribute.valid?
        # Mandar mensaje de error y redireccionar
      end
      @current_order_attribute.order_type_attribute = @order_type.order_type_attributes[index]
      @current_order_attribute.save!
    end
  end
  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @subsections = Subsection.where(is_disabled: nil)
    @order = Order.new
  end
  private
  def order_params
    params.require(:order).permit(:description_order, :reason_order)
  end

  def order_attribute_params
    params.require(:order).permit(:attribute_names)
  end
end
