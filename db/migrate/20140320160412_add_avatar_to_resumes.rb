class AddAvatarToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :avatar, :string
  end
end
