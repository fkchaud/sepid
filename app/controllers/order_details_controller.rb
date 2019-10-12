class OrderDetailsController < ApplicationController
  def show
    @order_detail = OrderDetail.find(params[:order_detail_id])
  end
  def adjust_preventive
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:order_detail_id])
    @new_value = ValueHistory.new(amount: params[:value_history][:amount],
                                  date:Time.now,
                                  value_status: ValueStatus.where(value_status_name: 'Estimado').take,
                                  order_detail: @order_detail,
                                  description: "Ajuste de preventivo")
    @project = @order.project
    @available_project_credits = @project.available_credits(@project.total_credits, @project.total_expenses)
    @available_subsection_credits = @available_project_credits[@order_detail.subsection].to_f + @order_detail.last_value.amount.to_f
    @final_value = @available_subsection_credits - @new_value.amount.to_f
    if @final_value < 0
      flash.now[:error] = "Los fondos disponibles no cubren el nuevo monto ingresado por #{-@final_value}"
      render "show"
      return
    else
      @new_value.save
      @order.order_status_histories.create(
          date_change_status_order: Time.now,
          reason_change_status_order: 'Ajuste de preventivo',
          order_status: OrderStatus.where(order_status_name: 'Armado y aprobación de preventivo').first
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
        order_status: OrderStatus.where(order_status_name: 'Pedido rechazado').first
    )
    redirect_to orders_path
  end
end
