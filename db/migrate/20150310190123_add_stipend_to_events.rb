class AddStipendToEvents < ActiveRecord::Migration
  def change
    add_column :events, :stipend, :boolean, default: false
  end
end
