class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.string :description_detail

      t.references :order, foreign_key: true
      t.references :subsection, foreign_key: true

      t.timestamps
    end
  end
end
