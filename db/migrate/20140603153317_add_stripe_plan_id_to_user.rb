class AddStripePlanIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_plan_id, :string
  end
end
