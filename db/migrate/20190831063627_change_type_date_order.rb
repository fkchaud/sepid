class ChangeTypeDateOrder < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :order_date, :date
  end
end
