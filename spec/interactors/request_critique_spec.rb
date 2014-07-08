require "spec_helper"
# include Capybara::Email::DSL

describe RequestCritique do
  let(:user) { create(:user, 
    stripe_customer_id: "cus_47oUnsvWTQWwPs",
    stripe_plan_id: "sub_4CFLiZFRyp52ya"
  ) }

  it "successfully creates a critique" do
    VCR.use_cassette("create_valid_stripe_critique_payment") do
      result = described_class.perform(
        user: user,
        critique_attributes: attributes_for(:critique)
      )

      expect(result).to be_success
      expect(result.critique).to be_persisted
      # expect(current_email.body).to include(result.critique.project_title)
      expect(result.critique.stripe_charge_id).to eq("ch_14E4np41K0MV6J6EXUuWhttu")
    end
  end
end