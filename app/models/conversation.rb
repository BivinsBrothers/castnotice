class Conversation < ActiveRecord::Base
  belongs_to :sender, class: User
  belongs_to :recipient, class: User

  has_many :messages
  accepts_nested_attributes_for :messages

  validates :sender, :recipient, presence: true

  scope :for_user, lambda { |uid| where('conversations.sender_id = ? OR conversations.recipient_id = ?', uid, uid) }
  scope :ordered_by_recent_activity, -> { order("recent_message_created_at DESC") }

  def other_correspondent_with(user)
    if user == self.sender
      self.recipient
    elsif user == self.recipient
      self.sender
    end
  end

  def mark_messages_read_for(recipient)
    messages.where(recipient_id: recipient.id).update_all(recipient_read_at: Time.current)
  end

  def has_unread_messages_for_user?(user)
    messages.
    where(recipient_id: user.id).
    where("recipient_read_at IS null").
    exists?
  end
end
