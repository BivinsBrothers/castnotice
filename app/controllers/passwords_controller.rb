class PasswordsController < Devise::PasswordsController
  skip_before_action :enforce_promo_code_access
end
