class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  serialization_scope :view_context

  before_action :store_location
  before_action :enforce_promo_code_access

  helper_method :current_resume
  helper_method :current_query
  helper_method :has_promo_code_or_logged_in?
  helper_method :is_promo_code?
  helper_method :has_breakthrough_pricing?
  helper_method :promo_code

  def current_resume
    current_user.resume
  end

  def current_query
    params[:q]
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
    unless has_promo_code_or_logged_in? || !term_of_service_page?
      redirect_to promo_path
    end
  end

  def term_of_service_page?
    controller_name == 'pages' && params["id"] != "tos" && params["id"] != "camp_terms"
  end

  def ensure_admin
    unless current_user && current_user.admin?
      redirect_to promo_path
    end
  end

  def ensure_superadmin
    user = User.find_by_email("hello@castnotice.com")
    unless current_user && current_user == user
      redirect_to promo_path
    end
  end

  def has_promo_code_or_logged_in?
    !! current_user || has_promo_code?
  end

  def has_promo_code?
    session[:promo_code].present?
  end

  def has_breakthrough_pricing?
    !! session[:breakthrough_pricing]
  end

  def promo_code
    session[:promo_code]
  end
end
