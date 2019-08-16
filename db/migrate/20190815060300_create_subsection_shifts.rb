# CambioInciso
class CreateSubsectionShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :subsection_shifts do |t|
      t.datetime :requested_date
      t.text :requested_cause

      t.timestamps
    end
  end
end
