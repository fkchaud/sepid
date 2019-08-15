class CreateOrderTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_types do |t|
      t.string :name_type_order
      t.string :descrption_type_order
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
