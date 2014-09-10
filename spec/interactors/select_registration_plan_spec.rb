require "spec_helper"

describe SelectRegistrationPlan do
  it "creates a plan for the customer in stripe and updates the user object accordingly" do
    VCR.use_cassette("stripe_create_valid_plan") do
      user = create(:user, stripe_customer_id: "cus_47oUnsvWTQWwPs")
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)

      result = described_class.call(
        user: user,
        customer: customer,
        stripe_plan: Stripe::Plans::MONTHLY.id
      )

      expect(result).to be_success
      expect(result.user.stripe_plan_id).to eq("sub_49dSVYmokuBR0P")
    end
  end
end
