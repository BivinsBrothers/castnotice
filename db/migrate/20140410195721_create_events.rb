class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :project_type
      t.string :region
      t.string :performer_type
      t.string :character
      t.string :pay
      t.string :union
      t.string :director

      t.text :story
      t.text :description
      t.text :audition

      t.datetime :audition_date
      t.datetime :start_date
      t.datetime :end_date

      t.boolean :paid, default: false, null: false

      t.timestamps
    end
  end
end
