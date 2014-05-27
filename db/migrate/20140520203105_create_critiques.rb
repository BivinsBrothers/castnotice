class CreateCritiques < ActiveRecord::Migration
  def change
    create_table :critiques do |t|
      t.column :project_title, :string
      t.column :notes, :text
      t.column :user_id, :integer
      t.column :uuid, :string

      t.index :user_id
      t.index :uuid

      t.timestamps
    end
  end
end
