# TODO: OrderStatusHistory pk should be order reference and date

class CreateOrderStatusHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_status_histories do |t|
      t.datetime :date_change_status_order
      t.string :reason_change_status_order

      t.references :order_status, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
