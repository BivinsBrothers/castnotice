class ConversationDecorator < Draper::Decorator
  delegate_all

  def unread_messages_for?
    Message.unread_for?(context[:user], self)
  end

 def correspondent
    if sender_id == context[:user].id
      recipient
    else
      sender
    end
  end
end
