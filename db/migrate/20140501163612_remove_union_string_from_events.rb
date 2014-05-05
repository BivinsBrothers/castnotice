class RemoveUnionStringFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :union
  end

  def down
    add_column :events, :union
  end
end
