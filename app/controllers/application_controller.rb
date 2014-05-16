class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_resume

  def current_resume
    current_user.resume
  end

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
