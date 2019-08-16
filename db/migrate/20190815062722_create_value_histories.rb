class CreateValueHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :value_histories do |t|
      t.datetime :date
      t.float :amount
      t.text :description

      t.references :order_detail, foreign_key: true
      t.references :value_status, foreign_key: true

      t.timestamps
    end
  end
end
