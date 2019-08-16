class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      # file_number = legajo
      t.integer :file_number
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :telephone
      t.integer :cuil
      t.datetime :is_disabled

      t.references :university_position, foreign_key: true
      t.references :user_profile, foreign_key: true

      t.timestamps
    end
  end
end
