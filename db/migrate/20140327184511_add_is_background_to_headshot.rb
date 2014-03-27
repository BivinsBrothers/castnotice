class AddIsBackgroundToHeadshot < ActiveRecord::Migration
  def change
    add_column :headshots, :is_background, :boolean, default: false, null: false
  end
end
