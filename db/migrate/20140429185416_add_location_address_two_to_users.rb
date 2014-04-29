class AddLocationAddressTwoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location_address_two, :string
  end
end
