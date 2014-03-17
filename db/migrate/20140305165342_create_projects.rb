class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_type
      t.string :title
      t.string :role
      t.string :director_studio
      t.integer :user_id

      t.timestamps
    end
  end
end
