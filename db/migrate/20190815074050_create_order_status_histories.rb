class CreateOrderStatusHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_status_histories do |t|
      t.datetime :date_change_status_order
      t.string :reason_change_status_order

      t.timestamps
    end
  end
end
