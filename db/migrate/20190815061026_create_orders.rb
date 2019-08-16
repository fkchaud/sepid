class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.text :reason_order
      t.text :description_order

      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
