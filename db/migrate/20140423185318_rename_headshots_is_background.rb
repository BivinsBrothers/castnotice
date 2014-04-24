class RenameHeadshotsIsBackground < ActiveRecord::Migration
  def change
    rename_column :headshots, :is_background, :background
  end
end
