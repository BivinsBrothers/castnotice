class ChangeResumesUnionsToFullJoinTable < ActiveRecord::Migration
  def up
    rename_table :resumes_unions, :resume_unions
    add_column :resume_unions, :id, :primary_key
    add_timestamps(:resume_unions)
  end

  def down
    remove_timestamps(:resume_unions)
    remove_column :resume_unions, :id
    rename_table :resume_unions, :resumes_unions
  end
end
