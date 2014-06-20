class PromoController < ApplicationController
  skip_before_action :enforce_promo_code_access
  skip_before_action :store_location

  def create
    if valid_coupon_codes.include?(params[:promo_code])
      session[:promo_code_success] = true
    end
    redirect_to root_path
  end

  private

  def valid_coupon_codes
    Figaro.env.coupon_codes.present? ? Figaro.env.coupon_codes.split(",") : []
  end
end
