class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :enforce_create_permission, only: [:create]

  def index
    @conversations = Conversation.for_user(current_user.id)
                                 .ordered_by_recent_activity
                                 .decorate(context: {user: current_user})
  end

  def new
    @recipient = User.find(params[:recipient_id])
    @conversation = Conversation.new
    @conversation.recipient_id = @recipient.id
    @conversation.messages.build
  end

  def show
    @conversation = Conversation.find(params[:id]).decorate(context: {user: current_user})
    @message = Message.new
  end

  def create
    @conversation = Conversation.new(
      conversation_params.merge({sender_id: current_user.id})
    )

    if @conversation.save
      flash[:notice] = "Your message has been sent"
      redirect_to conversation_path(@conversation)
    else
      @recipient = User.find(@conversation.recipient_id)
      render :new
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:subject, :recipient_id, messages_attributes: [:body])
  end

  def enforce_create_permission
    recipient = User.find(conversation_params[:recipient_id])
    unless can_send_messages_to?(recipient)
      redirect_to public_resume_path(recipient)
    end
  end
end
