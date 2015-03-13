class CreateRolePerformanceSkills < ActiveRecord::Migration
  def change
    create_table :role_performance_skills do |t|
      t.references :role, index: true
      t.references :performance_skill, index: true
    end
  end
end
