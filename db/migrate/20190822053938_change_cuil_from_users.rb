class ChangeCuilFromUsers < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :users, :cuil, :integer, limit: 8
      end
      dir.down do
        change_column :users, :cuil, :integer, limit: 4
      end
    end
  end
end
