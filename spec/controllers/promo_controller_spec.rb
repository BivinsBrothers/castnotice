require "spec_helper"

describe PromoController do
  describe "#create" do
    it "sets a session variable to true with a valid promo code" do
      post :create, promo_code: "BreakThru2014"

      expect(response).to redirect_to(root_path)
      expect(session[:allow_breakthrough_promo]).to be_true
    end

    it " does not set a session variable with an invalid promo code" do
      post :create, promo_code: "NoShoes1993"

      expect(response).to redirect_to(root_path)
      expect(session).not_to include(:allow_breakthrough_promo)
    end
  end
end
