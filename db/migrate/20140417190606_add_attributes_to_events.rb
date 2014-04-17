class AddAttributesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :producers, :string
    add_column :events, :writers, :string
    add_column :events, :location, :string
    add_column :events, :casting_director, :string
  end
end
