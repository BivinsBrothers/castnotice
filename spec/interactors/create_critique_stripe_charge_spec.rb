require "spec_helper"

describe CreateCritiqueStripeCharge do
  let(:breakthru_user) { create(:user, 
    stripe_customer_id: "cus_47oUnsvWTQWwPs",
    stripe_plan_id: "sub_4Mo72MSaDnWJdO"
  ) }
  let(:standard_user) { create(:user, 
    stripe_customer_id: "cus_47oUnsvWTQWwPs",
    stripe_plan_id: "sub_4CFLiZFRyp52ya"
  ) }
  let(:user_with_invalid_payment_info) { create(:user, 
    stripe_customer_id: "cus_4CKcopdQA6TpLA",
    stripe_plan_id: "sub_4CKcX10M49Xgsx"
  ) }
  let(:critique) { create(:critique) }

  it "charges stripe with a monthly or annual plan" do
    VCR.use_cassette("create_valid_stripe_critique_payment") do
      result = described_class.call(
        user: standard_user,
        critique: critique
      )

      expect(result).to be_success
      expect(result.critique.stripe_charge_id).to eq("ch_14E4np41K0MV6J6EXUuWhttu")
      expect(result.critique.payment_method).to eq("stripe")
    end
  end

  context "with a broadway plan" do
    it "gives 1 free critique" do
      result = described_class.call(
        user: breakthru_user,
        critique: critique
      )

      expect(result).to be_success
      expect(result.critique.stripe_charge_id).to be_nil
      expect(result.critique.payment_method).to eq("breakthru_free")
    end

    it "charges stripe for >=1 ctitique" do
      VCR.use_cassette("create_valid_stripe_critique_payment") do
        existing_critique = create(:critique, user: breakthru_user, payment_method: "breakthru_free")
        breakthru_user.reload
        result = described_class.call(
          user: breakthru_user,
          critique: critique
        )

        expect(result).to be_success
        expect(result.critique.stripe_charge_id).to eq("ch_14E4np41K0MV6J6EXUuWhttu")
        expect(result.critique.payment_method).to eq("stripe")
      end
    end
  end

  it "doesn't change anything when unsucessful" do
    VCR.use_cassette("create_invalid_stripe_critique_payment") do
      result = described_class.call(
        user: user_with_invalid_payment_info,
        critique: critique
      )

      expect(result).to be_failure
      expect(result.critique.stripe_charge_id).to be_nil
      expect(result.critique.payment_method).to be_nil
    end
  end
end
