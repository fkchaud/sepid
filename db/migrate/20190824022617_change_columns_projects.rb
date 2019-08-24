class ChangeColumnsProjects < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :projects, :start_date, :date
        change_column :projects, :ending_date, :date
      end
      dir.down do
        change_column :projects, :start_date, :datetime
        change_column :projects, :ending_date, :datetime
      end
    end
  end
end
