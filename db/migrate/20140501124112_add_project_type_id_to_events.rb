class AddProjectTypeIdToEvents < ActiveRecord::Migration
  def up
    add_column :events, :project_type_id, :integer
    add_index :events, :project_type_id
    remove_column :events, :project_type
  end

  def down
    add_column :events, :project_type
    remove_index :events, :project_type_id
    remove_column :events, :project_type_id
  end
end
