class MoveUserCareerDateToResume < ActiveRecord::Migration
  def up
    User.all.each { |u| u.create_resume if u.resume.nil? }

    add_column :projects, :resume_id, :integer
    Project.all.each { |p| p.update_attributes({resume_id: Resume.find_by_user_id(p.user_id).id}) }
    remove_column :projects, :user_id

    add_column :schools, :resume_id, :integer
    School.all.each { |s| s.update_attributes({resume_id: Resume.find_by_user_id(s.user_id).id}) }
    remove_column :schools, :user_id

    add_column :videos, :resume_id, :integer
    Video.all.each { |v| v.update_attributes({resume_id: Resume.find_by_user_id(v.user_id).id}) }
    remove_column :videos, :user_id

    add_column :headshots, :resume_id, :integer
    Headshot.all.each { |h| h.update_attributes({resume_id: Resume.find_by_user_id(h.user_id).id}) }
    remove_column :headshots, :user_id

    add_index :projects, :resume_id
    add_index :schools, :resume_id
    add_index :videos, :resume_id
    add_index :headshots, :resume_id
  end

  def down
    add_column :projects, :user_id, :integer
    Project.all.each { |p| p.update_attributes({user_id: Resume.find(p.resume_id).user_id}) }
    remove_column :projects, :resume_id

    add_column :schools, :user_id, :integer
    School.all.each { |s| s.update_attributes({user_id: Resume.find(s.resume_id).user_id}) }
    remove_column :schools, :resume_id

    add_column :videos, :user_id, :integer
    Video.all.each { |v| v.update_attributes({user_id: Resume.find(v.resume_id).user_id}) }
    remove_column :videos, :resume_id

    add_column :headshots, :user_id, :integer
    Headshot.all.each { |h| h.update_attributes({user_id: Resume.find(h.resume_id).user_id}) }
    remove_column :headshots, :resume_id

    add_index :projects, :user_id
    add_index :schools, :user_id
    add_index :videos, :user_id
    add_index :headshots, :user_id
  end
end
