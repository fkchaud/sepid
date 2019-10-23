class ChangeTypeOrderStatusChange < ActiveRecord::Migration[5.2]
  def change
    change_column :order_status_histories, :date_change_status_order, :date
  end
end
