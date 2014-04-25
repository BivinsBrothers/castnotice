class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id, :null => false
      t.integer :to, :null => false
      t.boolean :read, :default => false
      t.text :body, :null => false
      t.timestamps
    end
  end
end
