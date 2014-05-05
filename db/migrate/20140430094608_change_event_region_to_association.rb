class ChangeEventRegionToAssociation < ActiveRecord::Migration
  def up
    remove_column :events, :region
    add_column :events, :region_id, :integer
    add_index :events, :region_id
  end

  def down
    remove_index :events, :region_id
    remove_column :events, :region_id
    add_column :events, :region
  end
end
