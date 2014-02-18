class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :location_address, :string
    add_column :users, :location_city, :string
    add_column :users, :location_state, :string
    add_column :users, :location_zip, :string
    add_column :users, :birthday, :date
  end
end
