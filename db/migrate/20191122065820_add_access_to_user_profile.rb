class AddAccessToUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles,:access,:text
  end
end
