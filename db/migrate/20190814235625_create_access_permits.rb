class CreateAccessPermits < ActiveRecord::Migration[5.2]
  def change
    create_table :access_permits do |t|
      t.string :use_case_name
      t.string :use_case_url

      t.timestamps
    end
  end
end
