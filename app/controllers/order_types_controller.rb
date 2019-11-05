class OrderTypesController < ApplicationController

  # Tipos de datos a elegir
  TYPES = ['Número entero', 'Número decimal', 'Texto', 'Mail', 'Confirmación', 'Fecha'].freeze

  # Muestra todos los TipoPedido
  def index
    @order_types = OrderType.all
  end

  # Muestra el TipoPedido solicitado por URL
  def show
    @order_type = OrderType.find(params[:id])
  end

  # Instancia un nuevo TipoPedido
  def new
    @order_type = OrderType.new
  end

  # Muestra el TipoPedido solicitado por URL para su edición
  def edit
    @order_type = OrderType.find(params[:id])
  end

  # Crea un TipoPedido con los parámetros enviados por método POST de HTTP
  def create
    @order_type = OrderType.new(order_type_params)
    # Si el TipoPedido se puede guardar...
    if @order_type.save
      # ... informa del éxito ...
      flash[:success] = 'Tipo de Pedido creado con éxito.'
      # ... y redirige al #show del TipoPedido creado
      redirect_to @order_type
    # Si el TipoPedido no se puede guardar...
    else
      # ... carga el formulario de creación, poblado con los datos ingresados
      render 'new'
    end
  end

  # Actualiza un TipoPedido solicitado por URL con los parámetros enviados por método POST de HTTP
  def update
    @order_type = OrderType.find(params[:id])
    # Si el TipoPedido se puede actualizar...
    if @order_type.update order_type_params
      # ... informa del éxito ...
      flash[:success] = 'Tipo de Pedido actualizado con éxito.'
      # ... y redirige al #show del TipoPedido creado
      redirect_to @order_type
      # Si el TipoPedido no se puede guardar...
    else
      # ... carga el formulario de creación, poblado con los datos ingresados
      render 'edit'
    end

  end

  # Elimina un TipoPedido solicitado por URL
  def destroy
    @order_type = OrderType.find(params[:id])
    # Settea el atributo de desactivación, a él y a sus relacionados
    @order_type.update(is_disabled: Time.now)
    order_type_attributes = @order_type.order_type_attributes
    order_type_detail_attributes = @order_type.order_detail_attributes
    order_type_detail_attributes.each do |detail_attribute|
      detail_attribute.update(is_disabled: Time.now)
    end
    order_type_attributes.each do |attribute|
      attribute.update(is_disabled: Time.now)
    end
    # Redirige a la lista de TipoPedido
    redirect_to order_types_path
  end

  private

  # Lista de parámetros aprobados que se permiten recibir por POST (White List)
  def order_type_params
    params.require(:order_type)
          .permit(:name_type_order, :description_type_order)
  end

end