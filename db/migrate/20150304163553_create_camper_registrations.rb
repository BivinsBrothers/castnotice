class CreateCamperRegistrations < ActiveRecord::Migration
  def change
    create_table :camper_registrations do |t|
      t.integer :camp_id, null: false
      t.integer :order_id, null: false
    end
  end
end
