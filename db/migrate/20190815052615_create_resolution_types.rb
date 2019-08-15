class CreateResolutionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :resolution_types do |t|
      t.string :name
      t.text :description
      t.datetime :is_disabled

      t.timestamps
    end
  end
end
