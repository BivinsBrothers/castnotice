class ContactsController < ApplicationController
  skip_before_action :store_location

  def new
  end

  def create
    mail = Notifier.contact_us(params[:contact][:name],
                        params[:contact][:email],
                        params[:contact][:subject],
                        params[:contact][:content])
    if mail.deliver
      flash[:success] = "Your message has been sent to Cast Notice."
    else
      flash[:failure] = "Your message failed to send please try again."
    end
    redirect_to contact_path
  end

end