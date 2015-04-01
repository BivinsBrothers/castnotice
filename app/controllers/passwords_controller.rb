class PasswordsController < Devise::PasswordsController
  skip_before_action :enforce_promo_code_access

  protected
  def after_resetting_password_path_for(resource)
    signed_in_root_path(resource)
  end
end
