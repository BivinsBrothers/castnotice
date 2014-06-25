class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :staff, :text
    add_column :events, :pay_rate, :string
    add_column :events, :audition_times, :text
    add_column :events, :production_location, :text
  end
end
