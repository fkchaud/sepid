class CreateOrderDetailAttributeValues < ActiveRecord::Migration[5.2]
  def change
    create_table :order_detail_attribute_values do |t|
      t.string :value

      t.references :order_detail_attribute, foreign_key: true
      t.references :order_detail, foreign_key: true

      t.timestamps
    end
  end
end
