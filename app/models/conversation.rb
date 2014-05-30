class Conversation < ActiveRecord::Base
  belongs_to :sender, class: User
  belongs_to :recipient, class: User

  has_many :messages
  accepts_nested_attributes_for :messages

  validates :sender, :recipient, presence: true

  scope :for_user, lambda { |uid| where('conversations.sender_id = ? OR conversations.recipient_id = ?', uid, uid) }
  scope :ordered_by_recent_activity, -> { order("recent_message_created_at DESC") }

  def other_correspondent_for(sender)
    if sender == self.sender
      self.recipient
    elsif sender == self.recipient
      self.sender
    end
  end

  def mark_messages_read_for(recipient)
    messages.where(recipient_id: recipient.id).update_all(recipient_read_at: Time.current)
  end
end
