class PromoController < ApplicationController
  skip_before_action :enforce_promo_code_access
  skip_before_action :store_location

  def create
    if valid_coupon_codes.include?(params[:promo_code])
      session[:promo_code] = params[:promo_code]
      session[:breakthrough_pricing] = allow_breakthrough_pricing?
    end
    redirect_to root_path
  end

  private

  def valid_coupon_codes
    Figaro.env.coupon_codes.present? ? Figaro.env.coupon_codes.split(",") : []
  end

  def allow_breakthrough_pricing?
    session[:promo_code] == "BreakThru2014"
  end
end
