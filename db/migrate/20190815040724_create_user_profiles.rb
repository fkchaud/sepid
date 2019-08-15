class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.text :description
      t.datetime :is_disabled

      t.timestamps
    end

    create_table :access_permits_user_profiles, id: false do |t|
      t.belongs_to :access_permit, index: true
      t.belongs_to :user_profile, index: true
    end
  end
end
