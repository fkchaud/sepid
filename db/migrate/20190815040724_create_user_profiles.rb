class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.text :description
      t.datetime :is_disabled

      t.timestamps
    end

    create_join_table :access_permits, :user_profiles do |t|
      t.index :access_permit_id
      t.index :user_profile_id
    end
  end
end
