class CreateOrderTypeAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_type_attributes do |t|
      t.string :attribute_name
      t.string :type_attribute
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
