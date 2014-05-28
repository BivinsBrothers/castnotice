class Message < ActiveRecord::Base
  before_create :set_sender_and_receipient

  belongs_to :sender, class: User
  belongs_to :recipient, class: User
  belongs_to :conversation, touch: :recent_message_created_at

  # AB: This doesn't seem possible... maybe this needs to be handled in the Conversation model?
  # validates :conversation_id, presence: true

  def self.unread_for?(recipient, conversation)
    where(recipient_id: recipient.id).
    where(conversation_id: conversation.id).
    where("recipient_read_at IS null").
    present?
  end

  private

  def set_sender_and_receipient
    self.sender = conversation.sender
    self.recipient = conversation.recipient
  end
end
