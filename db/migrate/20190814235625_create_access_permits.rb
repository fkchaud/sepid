class CreateAccessPermits < ActiveRecord::Migration[5.2]
  def change
    create_table :access_permits do |t|
      t.string :useCaseName
      t.string :useCaseURL

      t.timestamps
    end
  end
end
