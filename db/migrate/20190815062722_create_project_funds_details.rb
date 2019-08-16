# DetalleFondoProyecto
class CreateProjectFundsDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :project_funds_details do |t|
      t.float :funds_amount
      t.integer :year

      t.references :subsection, foreign_key: true
      t.references :funds_destination, foreign_key: true
      t.references :subsection_shift, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
