class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    #render plain: params[:order].inspect
    #Se crea la orden
    @order = Order.new
    #Se buscan o crean todos los objetos relacionados
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:order][:project_id])
    @order_status =  OrderStatus.where(order_status_name:'Solicitado', is_disabled: nil).take
    @order.project = @project
    @order_status_history = @order.order_status_histories.new(date_change_status_order: Time.now,
                                                              reason_change_status_order:'Pedido iniciado')
    @order_status_history.order_status = @order_status
    #Se settean los atributos del pedido
    @order.order_date = Time.now.strftime("%d/%m/%Y")
    @order.description_order = params[:order][:description_order]
    @order.reason_order = params[:order][:reason_order]
    #Guardar el pedido
    params[:order][:attribute_names].each do |attribute|
      @order.order_type_attribute_values.new(value: attribute)
    end
    params[:order][:order_detail_attributes].each do |detail|
      detail_current = @order.order_details.new()
      #CONTINUAR DE ACÁ
    end
  end
  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @order = Order.new
  end
end
