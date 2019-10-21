class OrdersController < ApplicationController

  def index
    case current_user.user_profile.name
    when 'Investigador'
      @orders = Order.all.select do |o|
        o.project.director == current_user || o.project.codirector == current_user
      end
    when 'SeCYT_Admin'
      @orders = Order.all.select do |o|
        o.order_status.order_status_name == 'Pedido realizado'
      end
    when 'SeCYT_Sec'
      @orders = Order.all.select do |o|
        o.order_status.order_status_name == 'Aprobado por CYT'
      end
    when 'DEF_Admin'
      @orders = Order.all.select do |o|
        ['Aprobado por Secretario', 'Armado y aprobación de preventivo',
         'Licitación iniciada', 'Devengado realizado',
         'Pedido recibido', 'Pedido retirado'].include? o.order_status.order_status_name
      end
    when 'Super_Admin'
      @orders = Order.all
    else
      render 'layouts/forbidden', status: :forbidden
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.enabled
    if @order_types.empty?
      flash[:error] = 'No existe ningún tipo de pedido vigente, no se puede continuar con la acción.
                         Contactar con el personal a cargo'
      redirect_to welcome_index_path
      return
    end
  end

  def create
    # render plain: params[:order][:order_details_attributes].inspect
    # Crear el pedido
    @order = Order.new(order_params)
    # Setear la fecha del pedido
    @order.order_date = Time.now
    # Asociarle proyecto
    @order.project = Project.find(params[:project_id])
    @project = @order.project
    # Buscar el tipo de pedido seleccionado
    @order_type = OrderType.find(params[:order][:order_type_id])
    # Buscar los atributos vigentes del tipo de pedido
    @order_type_attributes = @order_type.order_type_attributes.reject do |ota|
      !ota.is_disabled.nil?
    end
    #  Buscar los atributos del detalle vigente del tipo de pedido
    @order_detail_attributes = @order_type.order_detail_attributes.reject do |oda|
      !oda.is_disabled.nil?
    end
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
    (0...(@order_type_attributes.length)).each do |index|
      # Crear los valores de los atributos
      current_order_attribute = @order.order_type_attribute_values.new(
        value: params[:order][:attribute_names][index]
      )
      # @flag = true unless current_order_attribute.valid?
      # Asociar el valor del atributo con el atributo
      current_order_attribute.order_type_attribute = @order_type_attributes[index]
    end
    if params[:order][:order_details_attributes].nil?
      flash.now[:error] = "No hay ningún detalle cargado"
      render 'continue'
      return
    else
      # Crear cada detalle con sus atributos y relaicones
      params[:order][:order_details_attributes].each do |_key, value|
        current_detail = @order.order_details.new
        (0...@order_detail_attributes.length).each do |index|
          current_detail_attribute = current_detail.order_detail_attribute_values.new(
              value: value[:attribute_names][index]
          )
          # @flag = true unless current_detail_attribute.valid?
          current_detail_attribute.order_detail_attribute = @order_detail_attributes[index]
        end
        current_detail.description_detail = value[:description_detail]
        current_subsection = Subsection.find(value[:subsection_id])
        current_detail.subsection = current_subsection
        # Acumular los montos para cada inciso
        amounts[current_subsection] += value[:attribute_names][-1].to_f
      end
    end
    # Verificar que los datos ingresados sean válidos
    if @flag
      render 'continue'
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
    @order.save
    # Guardar atributos del pedido
    @order.order_type_attribute_values.each do |order_attribute|
      order_attribute.save
    end
    # Guardar detalles
    @order.order_details.each do |detail|
      detail.save
      # Guardar atributos del detalle
      detail.order_detail_attribute_values.each do |detail_attribute|
        detail_attribute.save
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
        value_status: ValueStatus.enabled.find_by_value_status_name('Estimado')
      )
    end
    redirect_to orders_path
  end

  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @subsections = Subsection.where(is_disabled: nil)
    @order = Order.new
  end

  def update
    @order = Order.find(params[:id])
    @ref = ''
    case @order.order_status.order_status_name
    when 'Pedido realizado'
      @ref = 'Aprobado por CYT'
    when 'Aprobado por CYT'
      @ref = 'Aprobado por Secretario'
    when 'Aprobado por Secretario'
      @ref = 'Armado y aprobación de preventivo'
    when 'Armado y aprobación de preventivo', 'Licitación iniciada'
      @ref = 'Devengado realizado'
    when 'Devengado realizado'
      @ref = 'Pedido recibido'
    when 'Pedido recibido'
      @ref = 'Pedido retirado'
    else
      render 'layouts/forbidden', status: :method_not_allowed
      return
    end
    @order.order_status_histories.create(
      date_change_status_order: Time.now,
      reason_change_status_order: @ref,
      order_status: OrderStatus.enabled.find_by_order_status_name(@ref)
    )
    @director= @order.project.director
    @codirector = @order.project.codirector
    # Hay que mandarle el pedido también
    ChangeStatusMailer.with(user: @director, order: @order).notify_change.deliver_later
    ChangeStatusMailer.with(user: @codirector, order: @order).notify_change.deliver_later
    redirect_to orders_path
  end

  def start_tender
    @order = Order.find(params[:order_id])
    if current_user.user_profile.name == 'DEF_Admin'
      @order.order_status_histories.create(
        date_change_status_order: Time.now,
        reason_change_status_order: 'Licitación iniciada',
        order_status: OrderStatus.enabled.find_by_order_status_name('Licitación iniciada')
      )
      @director= @order.project.director
      @codirector = @order.project.codirector
      # Hay que mandarle el pedido también
      ChangeStatusMailer.with(user: @director, order: @order).notify_change.deliver_later
      ChangeStatusMailer.with(user: @codirector, order: @order).notify_change.deliver_later
      redirect_to orders_path
    end
  end

  def refuse_order
    # render plain: params[:order_status_history].inspect
    @order = Order.find(params[:order_id])
    @order.order_status_histories.create(
      date_change_status_order: Time.now,
      reason_change_status_order: params[:order_status_history][:reason_change_status_order],
      order_status: OrderStatus.where(order_status_name: 'Pedido rechazado').first
    )
    @director= @order.project.director
    @codirector = @order.project.codirector
    # Hay que mandarle el pedido también
    ChangeStatusMailer.with(user: @director, order: @order).notify_change.deliver_later
    ChangeStatusMailer.with(user: @codirector, order: @order).notify_change.deliver_later
    redirect_to orders_path
  end

  def cancel_order
    @order = Order.find(params[:order_id])
    @order.order_status_histories.create(
      date_change_status_order: Time.now,
      reason_change_status_order: 'Pedido cancelado',
      order_status: OrderStatus.enabled.find_by_order_status_name('Pedido cancelado')
    )
    redirect_to orders_path
  end

  def check_expenses
    @project = Project.find(params[:project_id])
    @years = (@project.start_date.year..@project.ending_date.year)
    @subsections = Subsection.where(is_disabled: nil)
    @orders_per_year = {}
    @expenses_per_years_subsection = {}
    @total_expenses_per_year = {}
    @total_expenses_per_year.default = 0.0
    @available_credits_per_subsection = {}
    @available_credits_per_subsection.default = 0.0
    @total_available_credits = {}
    @total_available_credits.default = 0.0
    @years.each do |year|
      @orders_per_year[year] = @project.orders.where('extract(year from order_date) = ?', year)
      @orders_per_year[year] = @orders_per_year[year].reject do |o|
        ['Pedido cancelado', 'Pedido rechazado'].include? o.order_status.order_status_name
      end
      @expenses_per_years_subsection[year] = @project.total_expenses(year)
      @available_credits_per_subsection[year] = @project.available_credits(@project.total_credits(year), @project.total_expenses(year), year)
      @subsections.each do |subsection|
        @total_expenses_per_year[year] += @expenses_per_years_subsection[year][subsection]
        @total_available_credits[year] += @available_credits_per_subsection[year][subsection]
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:description_order, :reason_order)
  end

  def order_attribute_params
    params.require(:order).permit(:attribute_names)
  end

end
