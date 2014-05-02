class ChangeEventsUnionsToFullJoinTable < ActiveRecord::Migration
  def up
    rename_table :events_unions, :event_unions
    add_column :event_unions, :id, :primary_key
    add_timestamps(:event_unions)
  end

  def down
    remove_timestamps(:event_unions)
    remove_column :event_unions, :id
    rename_table :event_unions, :events_unions
  end
end
