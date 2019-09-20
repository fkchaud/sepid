class OrdersController < ApplicationController

  def index
    if current_user.user_profile.name == 'SeCYT_Admin'
      @orders = Order.all.select do |o|
        o.order_status.order_status_name == 'Pedido realizado'
      end
    end
    if current_user.user_profile.name == 'SeCYT_Sec'
      @orders = Order.all.select do |o|
        o.order_status.order_status_name == 'Aprobado por CYT'
      end
    end
    if current_user.user_profile.name == 'DEF_Admin'
      @orders = Order.all.select do |o|
        ['Aprobado por Secretario', 'Armado y aprobación de preventivo'].include? o.order_status.order_status_name
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

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
    @order.order_date = Time.now
    # Asociarle proyecto
    @order.project = Project.find(params[:order][:project_id])
    @project = @order.project
    # Buscar el tipo de pedido seleccionado
    @order_type = OrderType.find(params[:order][:order_type_id])
    # Asociar tipo de pedido al pedido
    @order.order_type = @order_type
    # Asociar historial
    @order.order_status_histories.new(
      date_change_status_order: Time.now,
      reason_change_status_order: 'Pedido realizado',
      order_status: OrderStatus.where(order_status_name: 'Pedido realizado').first
    )
    # Buscar todos los incisos
    @subsections = Subsection.where(is_disabled: nil)
    # Bandera para comprobar si hubo error
    @flag = false
    # Validar el pedido
    @flag = true unless @order.valid?
    # Crear un hash en el que guardar los montos totales de cada inciso
    amounts = {}
    amounts.default = 0.0
    (0...(@order_type.order_type_attributes.length)).each do |index|
      # Ignorar si el atributo está dado de baja
      next unless @order_type.order_type_attributes[index].is_disabled.nil?
      # Crear los valores de los atributos
      current_order_attribute = @order.order_type_attribute_values.new(
          value: params[:order][:attribute_names][index]
      )
      #@flag = true unless current_order_attribute.valid?
      # Asociar el valor del atributo con el atributo
      current_order_attribute.order_type_attribute = @order_type.order_type_attributes[index]
    end
    # Crear cada detalle con sus atributos y relaicones
    params[:order][:order_details_attributes].each do |_key, value|
      current_detail = @order.order_details.new
      (0...@order_type.order_detail_attributes.length).each do |index|
        # Ignorar si el atributo está dado de baja
        next unless @order_type.order_detail_attributes[index].is_disabled.nil?
        current_detail_attribute = current_detail.order_detail_attribute_values.new(
          value: value[:attribute_names][index]
        )
        #@flag = true unless current_detail_attribute.valid?
        current_detail_attribute.order_detail_attribute = @order_type.order_detail_attributes[index]
      end
      current_detail.description_detail = value[:description_detail]
      current_subsection = Subsection.find(value[:subsection_id])
      current_detail.subsection = current_subsection
      # Acumular los montos para cada inciso
      amounts[current_subsection] += value[:attribute_names][-1].to_f
    end
    # Verificar que los datos ingresados sean válidos
    if @flag
      render "continue"
      return
    end
    # Verificar los creditos restantes de realizar la operacion
    available_credits = @project.available_credits(@project.available_credits, amounts)
    # Verificar que los fondos no sean negativos
    available_credits.each do |key, value|
      if value.negative?
        # Redireccionar y mostrar error
        flash.now[:error] = "El gasto del inciso #{key.name} es superior" \
                            "a los fondos disponibles por $#{-value}"
        render 'continue'
        return
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
    params[:order][:order_details_attributes].each do |_key, value|
      @amouts_values << value[:attribute_names][-1].to_f
    end
    (0...@order.order_details.length).each do |index|
      @order.order_details[index].value_histories.create(
        date: Time.now,
        amount: @amouts_values[index],
        value_status: ValueStatus.where(value_status_name: 'Estimado').first
      )
    end
  end

  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @subsections = Subsection.where(is_disabled: nil)
    @order = Order.new
  end

  def update
    @order = Order.find(params[:id])
    @order.order_status_histories.create(
        date_change_status_order: Time.now,
        reason_change_status_order: 'Aprobado por CYT',
        order_status: OrderStatus.where(order_status_name: 'Aprobado por CYT').first
    )
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:description_order, :reason_order)
  end

  def order_attribute_params
    params.require(:order).permit(:attribute_names)
  end

end
