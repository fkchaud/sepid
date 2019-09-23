class AddReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :order_type, foreign_key: true
  end
end
