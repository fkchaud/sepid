# DestinoFondos
class CreateFundsDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :funds_destinations do |t|
      t.string :name

      t.references :funds_resolution, foreign_key: true

      t.timestamps
    end
  end
end
