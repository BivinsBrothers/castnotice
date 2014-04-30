class RemoveNudityFromResume < ActiveRecord::Migration
  def up
    remove_column :resumes, :nudity
  end

  def down
    add_column :resumes, :nudity, :string
  end
end
