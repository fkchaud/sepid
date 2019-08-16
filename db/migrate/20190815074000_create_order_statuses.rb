class CreateOrderStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :order_statuses do |t|
      t.string :order_status_name
      t.text :order_status_description
      t.boolean :allow_cancel_order
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
