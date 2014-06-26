class RenameRollsToRoles < ActiveRecord::Migration
  def change
    rename_table :rolls, :roles
  end
end
