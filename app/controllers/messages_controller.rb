class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: :create
  before_action :can_reply_to_conversation, only: :create

  def index
  end

  def show
  end

  def create
    if @conversation.messages.create(message_params)
      flash[:notice] = "Your reply has been sent"
    else
      flash[:failure] = "Unable to reply to message"
    end

    redirect_to conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end

  def set_conversation
    unless @conversation = Conversation.find(message_params[:conversation_id])
      flash[:failure] = "Unable to reply to message"
      redirect_to conversation_path(@conversation)
    end
  end

  def can_reply_to_conversation
    @conversation.recipient_id == current_user.id
  end
end
