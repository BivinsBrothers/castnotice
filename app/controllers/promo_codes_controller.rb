class PromoCodesController < ApplicationController
  def create
    if ["BreakThru2014", "YoungActors2014"].include?(params[:promo_code])
      session[:allow_breakthrough_promo] = true
      redirect_to new_user_registration_path(account_type: Stripe::Plans::BROADWAY, promo: params[:promo_code])
    else
      redirect_to root_path
    end
  end
end
