class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :school
      t.string :major
      t.string :degree
      t.integer :user_id

      t.timestamps
    end
  end
end
