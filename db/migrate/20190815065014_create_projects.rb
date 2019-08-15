class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :project_code
      t.string :project_name
      t.string :project_description
      t.datetime :start_date
      t.datetime :ending_date
      t.string :technological_scientific_unit
      t.string :project_program
      t.string :activity_type

      t.timestamps
    end
  end
end
