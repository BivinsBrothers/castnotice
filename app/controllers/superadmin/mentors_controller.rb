class Superadmin::MentorsController < ApplicationController
  before_action :ensure_superadmin

  def send_invite
    email = params[:email]
    mail = Notifier.invite_talent_mentors(email)
    if mail.deliver
      flash[:success] = "Your invite has been sent."
    else
      flash[:failure] = "Your invite failed to be sent, please try again."
    end
    redirect_to admin_users_path
  end
end
