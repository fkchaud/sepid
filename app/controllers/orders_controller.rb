class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    # render plain: params[:order][:order_details_attributes].inspect
    # Crear el pedido
    @order = Order.new(order_params)
    # Setear la fecha del pedido
    @order.order_date = Time.now.strftime('%m/%d/%Y')
    # Asociarle proyecto
    @order.project = Project.find(params[:order][:project_id])
    # Buscar el tipo de pedido seleccionado
    @order_type = OrderType.find(params[:order][:order_type_id])
    # Asociar historial
    @order.order_status_histories.new(date_change_status_order: Time.now,
                                      reason_change_status_order: "Pedido realizado",
                                      order_status: OrderStatus.where(order_status_name: "Pedido realizado").take)
    # Validar el pedido
    unless @order.valid?
      # Mandar mensaje de error y redireccionar
    end
    # Buscar todas las instancias de incisos
    @subsections = Subsection.enabled.all
    # Crear un hash en el que guardar los montos totales de cada inciso
    @amounts = {}
    @subsections.each do |x|
      @amounts[x.name] = 0.0
    end
    # Buscar todos los detalles de fondos del proyecto actual
    @project_founds_details = ProjectFundsDetail.where(year: Time.now.year, project: @project)
    # Calcular todos los montos disponibles
    @project_founds_details.each do |founds_detail|
      @amounts[founds_detail.subsection.name] = founds_detail.funds_amount
    end
    (0...(@order_type.order_type_attributes.length)).each do |index|
      # Crear los valores de los atributos
      @current_order_attribute = @order.order_type_attribute_values.new(value: params[:order][:attribute_names][index])
      unless @current_order_attribute.valid?
        # Mandar mensaje de error y redireccionar
      end
      # Asociar el valor del atributo con el atributo
      @current_order_attribute.order_type_attribute = @order_type.order_type_attributes[index]
    end
    # Crear cada detalle con sus atributos y relaicones
    params[:order][:order_details_attributes].each do |key, value|
      # Cambiar la siguiente línea de código en el futuro
      @current_detail = @order.order_details.new(description_detail: "Sanata")
      (0...@order_type.order_detail_attributes.length).each do |index|
        @current_detail_attribute = @current_detail.order_detail_attribute_values.new(value: value[:attribute_names][index])
        @current_detail_attribute.order_detail_attribute = @order_type.order_detail_attributes[index]
      end
      @current_subsection = Subsection.find(params[:order][:subsection_id])
      @current_detail.subsection = @current_subsection
      # Acumular los montos para cada subsección
      @amounts[@current_subsection.name] -= value[:attribute_names][-1].to_f
    end
    # Verificar que los fondos no sean negativos
    @amounts.each do |key, value|
      if value  < 0
        # Redireccionar y mostrar error
      end
    end
    # Guardar todas las entidades
    # Guardar pedido
    @order.save!
    # Guardar atributos del pedido
    @order.order_type_attribute_values.each do |order_attribute|
      order_attribute.save!
    end
    # Guardar detalles
    @order.order_details.each do |detail|
      detail.save!
      # Guardar atributos del detalle
      detail.order_detail_attribute_values.each do |detail_attribute|
        detail_attribute.save!
      end
    end
    @amouts_values = []
    params[:order][:order_details_attributes].each do |key, value|
      @amouts_values << value[:attribute_names][-1].to_f
    end
    (0...@order.order_details.length).each do |index|
      @order.order_details[index].value_histories.create(date: Time.now,
                                                         amount: @amouts_values[index],
                                                         value_status: ValueStatus.where(value_status_name: "Estimado"))
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
