class AddColumnToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :descriptive_tag, :string
  end
end
