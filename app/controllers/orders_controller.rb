class OrdersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @order = Order.new
    @order_types = OrderType.where(is_disabled: nil)
  end
  def create
    #render plain: params[:order][:order_details_attributes].values.inspect
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
    #Crear los atributos del pedido
    for i in (0...params[:order][:attribute_names].length)
      next if (i % 2 != 0)
      @order.order_type_attribute_values.new(value: params[:order][:attribute_names][i],
                                             order_type_attribute: OrderTypeAttribute.find(params[:order][:attribute_names][i+1]))
    end
    #Crear los detalles junto con sus atributos
    params_details = params[:order][:order_details_attributes].values
    params_details.each do |detail|
      @current_detail = @order.order_details.new()
      for j in (0... detail[:attribute_names].length)
        next if (j % 2 != 0)
        @current_detail.order_detail_attribute_values.new(value: detail[:attribute_names][j],
                                                          order_detail_attribute: OrderDetailAttribute.find(detail[:attribute_names][j+1]))
      end
    end
  end
  def continue
    @order_type = OrderType.find(params[:order][:order_type_id])
    @project = Project.find(params[:project_id])
    @subsections = Subsection.where(is_disabled: nil)
    @order = Order.new
  end
end
