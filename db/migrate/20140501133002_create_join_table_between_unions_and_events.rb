class CreateJoinTableBetweenUnionsAndEvents < ActiveRecord::Migration
  def change
    create_join_table :events, :unions do |t|
      t.index :event_id
      t.index :union_id
    end
  end
end
