class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.column :conversation_id, :integer
      t.column :sender_id, :integer
      t.column :recipient_id, :integer
      t.column :body, :text
      t.column :recipient_read_at, :datetime

      t.index :conversation_id
      t.index :sender_id
      t.index :recipient_id

      t.timestamps
    end
  end
end
