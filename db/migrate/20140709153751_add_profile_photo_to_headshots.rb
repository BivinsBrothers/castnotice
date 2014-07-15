class AddProfilePhotoToHeadshots < ActiveRecord::Migration
  def change
    add_column :headshots, :profile_photo, :boolean, default: false, null: false
  end
end
