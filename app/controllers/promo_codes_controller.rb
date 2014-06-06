class PromoCodesController < ApplicationController
  def create
    if params[:promo_code] == "breakthrough"
      session[:allow_breakthrough_promo] = true
      redirect_to new_user_registration_path(account_type: Stripe::Plans::BROADWAY)
    else
      redirect_to root_path
    end
  end
end
