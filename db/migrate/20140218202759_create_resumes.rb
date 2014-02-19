class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.integer :height
      t.integer :weight
      t.string :hair_color
      t.string :eye_color
      t.string :phone
      t.string :unions
      t.string :agent_name
      t.string :agent_phone
      t.string :additional_skills

      t.timestamps
    end
  end
end
