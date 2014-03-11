class AddColumnToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :teacher, :string
    add_column :schools, :years, :integer
  end
end
