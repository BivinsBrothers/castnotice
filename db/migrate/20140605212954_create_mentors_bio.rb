class CreateMentorsBio < ActiveRecord::Migration
  def change
    create_table :mentor_bios do |t|
      t.string :company
      t.string :company_address
      t.integer :company_phone
      t.string :past_company
      t.string :current_projects
      t.string :teaching_experience
      t.string :talent_expertise, array: true, default: '{}'
      t.string :dance_style, array: true, default: '{}'
      t.string :education_experience
      t.string :artistic_organizations
      t.integer :user_id
    end
  end
end
