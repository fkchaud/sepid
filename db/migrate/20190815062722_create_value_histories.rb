class CreateValueHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :value_histories do |t|
      t.datetime :date
      t.float :amount
      t.string :description

      t.timestamps
    end
  end
end
