class CreateCampersList < ActiveRecord::Migration
  def change
    create_table :campers_lists do |t|
      t.string :user_email
      t.integer :order_id
      t.string :code
    end
  end
end
