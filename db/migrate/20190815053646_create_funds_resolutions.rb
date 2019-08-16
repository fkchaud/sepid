class CreateFundsResolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :funds_resolutions do |t|
      t.string :number
      t.date :date

      t.references :resolution_type, foreign_key: true

      t.timestamps
    end
  end
end
