# HistorialEstadoCambioInciso
class CreateSubsectionShiftStatusHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :subsection_shift_status_histories do |t|
      t.date :date
      t.references :subsection_shift_status, foreign_key: true
      t.references :subsection_shift, foreign_key: true

      t.timestamps
    end
  end
end
