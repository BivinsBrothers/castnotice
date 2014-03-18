class AddColumnToSchoolsEducationType < ActiveRecord::Migration
  def change
    add_column :schools, :education_type, :string
    add_column :schools, :instruments, :string
  end
end
