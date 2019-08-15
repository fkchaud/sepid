class CreateValueAttributeTypeOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :value_attribute_type_orders do |t|
      t.object :value

      t.timestamps
    end
  end
end
