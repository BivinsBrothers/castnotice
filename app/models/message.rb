class Message < ActiveRecord::Base
  belongs_to :sender, class: User
  belongs_to :recipient, class: User
  belongs_to :conversation, touch: :recent_message_created_at

  validates :sender_id, :recipient_id, presence: true

  def self.unread_for?(recipient, conversation)
    where(recipient_id: recipient.id).
    where(conversation_id: conversation.id).
    where("recipient_read_at IS null").
    exists?
  end
end
