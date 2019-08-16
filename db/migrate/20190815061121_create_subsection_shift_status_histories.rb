# HistorialEstadoCambioInciso
class CreateSubsectionShiftStatusHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :subsection_shift_status_histories do |t|
      t.datetime :date

      t.references :subsection_shift_status,
                   foreign_key: true,
                   index: { name: 'subsection_shift_status_fk_index' }
      t.references :subsection_shift,
                   foreign_key: true,
                   index: { name: 'subsection_shift_fk_index' }

      t.timestamps
    end
  end
end
