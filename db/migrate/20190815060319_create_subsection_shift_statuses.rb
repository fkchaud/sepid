# EstadoCambioInciso
class CreateSubsectionShiftStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :subsection_shift_statuses do |t|
      t.string :name
      t.text :description
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
