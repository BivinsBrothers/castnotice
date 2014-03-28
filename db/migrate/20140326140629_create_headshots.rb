class CreateHeadshots < ActiveRecord::Migration
  def change
    create_table :headshots do |t|
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
