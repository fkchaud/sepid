class OrderDetailsController < ApplicationController
  def show
    @order_detail = OrderDetail.find(params[:order_detail_id])
    @last_value = @order_detail.last_value
  end

  def adjust_preventive
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:order_detail_id])
    @last_value = ValueHistory.new(amount: params[:value_history][:amount],
                                   date: Time.now,
                                   value_status: ValueStatus.enabled.find_by_value_status_name('Estimado'),
                                   order_detail: @order_detail,
                                   description: 'Ajuste de preventivo')
    @project = @order.project
    @available_project_credits = @project.available_credits(@project.total_credits, @project.total_expenses)
    @available_subsection_credits = @available_project_credits[@order_detail.subsection].to_f + @order_detail.last_value.amount.to_f
    @final_value = @available_subsection_credits - @last_value.amount.to_f
    if @final_value.negative?
      flash.now[:error] = "Los fondos disponibles no cubren el nuevo monto ingresado por $#{-@final_value}"
      render 'show'
      return
    else
      @last_value.save
      @order.order_status_histories.create(
        date_change_status_order: Time.now,
        reason_change_status_order: 'Ajuste de preventivo',
        order_status: OrderStatus.enabled.find_by_order_status_name('Armado y aprobación de preventivo')
      )
      redirect_to orders_path
      return
    end
  end

  def refused_preventive
    @order = Order.find(params[:order_id])
    @order.order_status_histories.create(
      date_change_status_order: Time.now,
      reason_change_status_order: 'Fondos insuficientes',
      order_status: OrderStatus.enabled.find_by_order_status_name('Pedido rechazado')
    )
    redirect_to orders_path
  end
end
