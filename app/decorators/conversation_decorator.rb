class ConversationDecorator < Draper::Decorator
  delegate_all

  def unread_messages_for?
    self.messages.where(recipient_id: context[:user].id).where("recipient_read_at IS null").present?
  end

 def correspondent
    if sender_id == context[:user].id
      recipient
    else
      sender
    end
  end
end
