class CreateValueStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :value_statuses do |t|
      t.string :value_status_name
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
