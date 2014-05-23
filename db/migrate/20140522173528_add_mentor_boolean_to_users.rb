class AddMentorBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mentor, :boolean, default: false, null: false
  end
end
