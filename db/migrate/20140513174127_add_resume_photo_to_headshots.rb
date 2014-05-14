class AddResumePhotoToHeadshots < ActiveRecord::Migration
  def change
    add_column :headshots, :resume_photo, :boolean, default: false, null: false
  end
end
