class AddOrderToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :display_order, :integer
  end
end
