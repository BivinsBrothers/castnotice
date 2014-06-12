class SessionsController < Devise::SessionsController
  skip_before_action :enforce_promo_code_access
end
