class OrderDetailsController < ApplicationController
  def show
    @order_detail = OrderDetail.find(params[:id])
  end
  def adjust_preventive

  end
end
