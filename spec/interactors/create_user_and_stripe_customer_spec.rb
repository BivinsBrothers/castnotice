require "spec_helper"

describe CreateUserAndStripeCustomer do
  it "creates a stripe customer and user and selects a plan" do
    VCR.use_cassette("stripe_create_valid_customer") do
      result = described_class.perform(
        user_attributes: attributes_for(:user),
        stripe_token: "tok_1047oT41K0MV6J6EJZBa075P",
        stripe_plan: Stripe::Plans::MONTHLY
      )
      expect(result).to be_success
      expect(result.user).to be_persisted
      expect(result.user.stripe_customer_id).to eq("cus_47oUnsvWTQWwPs")
      expect(result.user.stripe_plan_id).to eq("sub_49daEYJN724MR2")
    end
  end

  it "cleans up after itself when there is a failed condition" do
    VCR.use_cassette("stripe_create_invalid_customer", record: :new_episodes) do
      result = described_class.perform(
        user_attributes: attributes_for(:user),
        stripe_token: "invalid_token"
      )
      expect(result).not_to be_success
      expect(result.user).not_to be_persisted
      expect(result.user.stripe_customer_id).to be_nil
      expect(result.user.stripe_plan_id).to be_nil
    end
  end
end
