class AddAgeRangeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :age_range, :int4range
  end
end
