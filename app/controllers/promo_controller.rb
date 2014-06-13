class PromoController < ApplicationController
  skip_before_action :enforce_promo_code_access

  def create
    if valid_coupon_codes.include?(params[:promo_code])
      session[:allow_breakthrough_promo] = true
    end
    redirect_to root_path
  end

  private

  def valid_coupon_codes
    Figaro.env.coupon_codes.present? ? Figaro.env.coupon_codes.split(",") : []
  end
end
