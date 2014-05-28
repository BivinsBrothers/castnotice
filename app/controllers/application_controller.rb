class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_location

  helper_method :current_resume
  helper_method :current_query
  helper_method :can_send_messages_to
  helper_method :can_send_messages

  def current_resume
    current_user.resume
  end

  def current_query
    params[:q]
  end

  def can_send_messages
    current_user.present? && current_user.talent?
  end

  def can_send_messages_to(recipient)
    can_send_messages && current_user.id != recipient.id
  end

  protected

  def store_location
    devise_routes = %w(/users/sign_in /users/sign_up /users/password /users/sign_out)

    if !devise_routes.include?(request.fullpath) && !request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || dashboard_path
  end
end
