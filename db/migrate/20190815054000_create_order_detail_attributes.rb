class CreateOrderDetailAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_detail_attributes do |t|
      t.string :attribute_name
      t.string :attribute_type
      t.datetime :is_disabled

      t.references :order_type, foreign_key: true

      t.timestamps
    end
  end
end
