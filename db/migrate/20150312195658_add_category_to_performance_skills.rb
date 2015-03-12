class AddCategoryToPerformanceSkills < ActiveRecord::Migration
  def change
    add_column :performance_skills, :category, :string
  end
end
