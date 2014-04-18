class AddIndexToAuditionDate < ActiveRecord::Migration
  def up
    add_index :events, :audition_date
  end

  def down
    remove_index :events, column: :audition_date
  end
end
