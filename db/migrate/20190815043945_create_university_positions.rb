class CreateUniversityPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :university_positions do |t|
      t.string :name
      # importeViatico
      t.float :per_travel_payment
      # importeAlmuerzo
      t.float :per_lunch_payment
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
