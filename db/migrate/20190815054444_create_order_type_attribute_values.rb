class CreateOrderTypeAttributeValues < ActiveRecord::Migration[5.2]
  def change
    create_table :order_type_attribute_values do |t|
      t.string :value

      t.references :order_type_attribute, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
