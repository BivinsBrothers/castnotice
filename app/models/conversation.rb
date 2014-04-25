class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :messages


  def set_messages
    @messages = Messages.where(params[:id])
  end
end
