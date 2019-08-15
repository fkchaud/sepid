class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.string :reason_order
      t.string :description_order

      t.timestamps
    end
  end
end
