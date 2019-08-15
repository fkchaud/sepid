class CreateAttributeDetailOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :attribute_detail_orders do |t|
      t.string :attribute_name
      t.string :attribute_type
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
