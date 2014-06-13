require "spec_helper"

describe PromoController do
  describe "#create" do
    it "sets a session variable to true with a valid promo code" do
      post :create, promo_code: "BreakThru2014"

      expect(response).to redirect_to(root_path)
      expect(session[:promo_code_success]).to be_true
    end

    it " does not set a session variable with an invalid promo code" do
      post :create, promo_code: "NoShoes1993"

      expect(response).to redirect_to(root_path)
      expect(session).not_to include(:promo_code_success)
    end
  end
end
