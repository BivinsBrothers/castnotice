class Conversation < ActiveRecord::Base
  belongs_to :sender, class: User
  belongs_to :recipient, class: User

  has_many :messages
  accepts_nested_attributes_for :messages

  validates :sender, :recipient, presence: true

  scope :for_user, lambda { |uid| where('conversations.sender_id = ? OR conversations.recipient_id = ?', uid, uid) }
  scope :ordered_by_recent_activity, -> { order("recent_message_created_at DESC") }
end
