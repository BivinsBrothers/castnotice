require "spec_helper"

describe CreateStripeCustomer do
  let(:user) { create(:user) }
  it "creates a stripe customer" do
    VCR.use_cassette("stripe_create_valid_customer") do
      result = CreateStripeCustomer.perform(
        user: user,
        stripe_token: "tok_1047oT41K0MV6J6EJZBa075P"
      )
      expect(result).to be_success
      expect(user.stripe_customer_id).to eq("cus_47oUnsvWTQWwPs")
    end
  end

  it "changes nothing with invalid credit card data" do
    VCR.use_cassette("stripe_create_invalid_customer") do
      result = CreateStripeCustomer.perform(
        user: user,
        stripe_token: "fake_token"
      )
      expect(result).not_to be_success
    end
  end
end
