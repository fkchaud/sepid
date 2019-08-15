class CreateProjectTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :project_types do |t|
      t.string :name
      # finalidad
      t.string :purpose
      t.string :function
      t.string :program
      t.string :activity
      t.string :financing
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
