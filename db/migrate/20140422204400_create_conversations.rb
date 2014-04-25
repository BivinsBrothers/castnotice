class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :subject
      t.integer :from, :null => false
      t.integer :to, :null => false
      t.timestamp :closed_at
      

      t.timestamps
    end
  end
end
