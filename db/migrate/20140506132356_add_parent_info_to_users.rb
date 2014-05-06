class AddParentInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent_name, :string
    add_column :users, :parent_email, :string
    add_column :users, :parent_location, :string
    add_column :users, :parent_location_two, :string
    add_column :users, :parent_city, :string
    add_column :users, :parent_state, :string
    add_column :users, :parent_zip, :string
    add_column :users, :parent_phone, :string
  end
end
