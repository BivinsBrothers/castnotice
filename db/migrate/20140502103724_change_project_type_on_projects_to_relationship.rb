class ChangeProjectTypeOnProjectsToRelationship < ActiveRecord::Migration
  def up
    add_column :projects, :project_type_id, :integer
    add_index :projects, :project_type_id
    remove_column :projects, :project_type
  end

  def down
    add_column :projects, :project_type, :string
    remove_column :projects, :project_type_id
  end
end
