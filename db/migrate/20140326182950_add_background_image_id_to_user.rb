class AddBackgroundImageIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :background_image_id, :integer
  end
end
