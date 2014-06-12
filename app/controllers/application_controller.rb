class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_location
  before_action :enforce_promo_code_access

  helper_method :current_resume
  helper_method :current_query
  helper_method :should_see_navigation?

  def current_resume
    current_user.resume
  end

  def current_query
    params[:q]
  end

  def should_see_navigation?
    !! current_user || has_promo_code?
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

  def enforce_promo_code_access
    unless current_user || has_promo_code? || is_promo_entry_or_sign_on?
      redirect_to promo_path
    end
  end

  def has_promo_code?
    session[:allow_breakthrough_promo] == true
  end

  def is_promo_entry_or_sign_on?
    [promo_path, promo_path].include?(request.path) ||
      ["devise/sessions", "devise/passwords"].include?(params[:controller])
  end
end
