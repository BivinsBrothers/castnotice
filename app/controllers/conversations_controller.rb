class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :enforce_messaging_permissions

  def index
    @conversations = Conversation.for_user(current_user.id).ordered_by_recent_activity
  end

  def new
    @recipient = User.find(params[:recipient_id])

    @conversation = Conversation.new({
      recipient_id: @recipient.id,
      sender_id: current_user.id
    })

    @conversation.messages.build({
      recipient_id: @recipient.id,
      sender_id: current_user.id
    })
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
    @conversation.mark_messages_read_for(current_user)

    @correspondent = @conversation.other_correspondent_with(current_user)

    @message = Message.new({
      recipient_id: @conversation.other_correspondent_with(current_user).id,
      sender_id: current_user.id
    })
  end

  def create
    @recipient = User.find(conversation_params[:recipient_id])

    unless current_user.can_send_messages_to?(@recipient)
      redirect_to public_resume_path(@recipient), notice: "You are not allowed to send this user a message"
    end

    @conversation = Conversation.new(conversation_params)
    @conversation.messages.first.sender = current_user
    @conversation.sender = current_user

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
    params.require(:conversation).permit(:subject, :recipient_id, :sender_id,
                                         messages_attributes: [:body, :recipient_id])
  end

  def enforce_messaging_permissions
    unless current_user.can_send_messages?
      redirect_to dashboard_path, notice: "You do not have permission to send messages"
    end
  end
end
