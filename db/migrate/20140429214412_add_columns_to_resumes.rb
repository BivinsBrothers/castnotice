class AddColumnsToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :manager_name, :string
    add_column :resumes, :manager_phone, :string
  end
end
