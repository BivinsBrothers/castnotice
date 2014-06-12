class PromoController < ApplicationController
  skip_before_action :enforce_promo_code_access

  def create
    if ["BreakThru2014", "YoungActors2014"].include?(params[:promo_code])
      session[:allow_breakthrough_promo] = true
    end
    redirect_to root_path
  end
end
