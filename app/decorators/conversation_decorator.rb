class ConversationDecorator < Draper::Decorator
  delegate_all

  def has_unread_messages?
    Message.unread_for?(context[:user], self)
  end

 def correspondent
   self.other_correspondent_for(context[:user])
  end
end
