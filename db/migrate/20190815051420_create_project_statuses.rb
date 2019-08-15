class CreateProjectStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :project_statuses do |t|
      t.string :name
      t.text :description
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
