class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.text :description
      t.string :gender
      t.string :ethnicity
      t.int4range :age_range
      t.integer :event_id

      t.timestamps
    end
  end
end
