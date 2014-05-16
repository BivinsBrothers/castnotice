class MoveUserCareerDateToResume < ActiveRecord::Migration
  def up
    add_column :projects, :resume_id, :integer
    Project.all.each { |p| p.update_attributes({resume_id: p.user.resume_id}) }
    remove_column :projects, :user_id

    add_column :schools, :resume_id, :integer
    School.all.each { |s| s.update_attributes({resume_id: s.user.resume_id}) }
    remove_column :schools, :user_id

    add_column :videos, :resume_id, :integer
    Video.all.each { |v| v.update_attributes({resume_id: v.user.resume_id}) }
    remove_column :videos, :user_id

    add_column :headshots, :resume_id, :integer
    Headshot.all.each { |h| h.update_attributes({resume_id: h.user.resume_id}) }
    remove_column :headshots, :user_id

    add_index :projects, :resume_id
    add_index :schools, :resume_id
    add_index :videos, :resume_id
    add_index :headshots, :resume_id
  end

  def down
    add_column :projects, :user_id, :integer
    Project.all.each { |p| p.update_attributes({user_id: p.resume.user_id}) }
    remove_column :projects, :resume_id

    add_column :schools, :user_id, :integer
    School.all.each { |s| s.update_attributes({user_id: s.resume.user_id}) }
    remove_column :schools, :resume_id

    add_column :videos, :user_id, :integer
    Video.all.each { |v| v.update_attributes({user_id: v.resume.user_id}) }
    remove_column :videos, :resume_id

    add_column :headshots, :user_id, :integer
    Headshot.all.each { |h| h.update_attributes({user_id: h.resume.user_id}) }
    remove_column :headshots, :resume_id

    add_index :projects, :user_id
    add_index :schools, :user_id
    add_index :videos, :user_id
    add_index :headshots, :user_id
  end
end
