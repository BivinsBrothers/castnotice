class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.column :sender_id, :integer
      t.column :recipient_id, :integer
      t.column :subject, :string
      t.column :recent_message_created_at, :datetime

      t.index  :sender_id
      t.index  :recipient_id

      t.timestamps
    end
  end
end
