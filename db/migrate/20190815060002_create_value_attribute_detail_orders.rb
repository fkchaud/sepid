class CreateValueAttributeDetailOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :value_attribute_detail_orders do |t|
      t.object :value

      t.timestamps
    end
  end
end
