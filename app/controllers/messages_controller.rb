class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    
    # these queries work but they need to also:
    # 1) show if any messages have a read = true on messages to the current user
    # 2) also sort by last new message.
    from_user = Conversation.where(:from => current_user.id).joins("join users f ON conversations.to = f.id").select("conversations.id, conversations.subject, f.name as with")
    to_user = Conversation.where(:to => current_user.id).joins("join users t ON conversations.from = t.id").select("conversations.id, conversations.subject, t.name as with")
    @conversations = to_user + from_user
    
    render :index
    
  end

  def show
    
    @conversation = Conversation.find(params[:id])
    if @conversation.to == current_user.id ? @with = User.find(@conversation.from).name : @with = User.find(@conversation.to).name
    end
    @messages = Conversation.where(:id => params[:id]).joins("join messages ON conversations.id = messages.conversation_id").select("messages.id, messages.to, messages.created_at, messages.body")
    
      render :show
  end

end
