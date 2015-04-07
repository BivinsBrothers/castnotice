require 'spec_helper'

feature "camper membership", mysql: true do
  context "camper request a critique" do
    context "annual subscription" do
      before { proxy.cache.scope_to "annual_subscription" }
      it "creates the strip plan", vcr: {cassette_name: "feature_camper_annual_subscription"}, js: true do
        user = create(:user, email: "john@example.com", sign_in_count: 3)
        log_in user
        click_link "Request Critique"
        click_button "annual-btn"

        within("#membership_annual") do
          fill_in "Card Number", with: "4242424242424242"
          fill_in "Expiration (MM/YYYY)", with: "01/2017"
          fill_in "Security Code", with: "123"
          click_button "Submit"
        end

        expect(page).to have_content "Submit Critique Request"
        click_link "Account Information"
        account_information = Dom::AccountInformation.first
        expect(account_information.current_subscription_plan).to eq("Annual Subscription")
      end
    end

    context "montlhy subscription" do
      before { proxy.cache.scope_to "monthly_subscription" }
      it "creates the stripe plan", vcr: {cassette_name: "feature_camper_monthly_subscription"}, js: true do
        user = create(:user, email: "john@example.com", sign_in_count: 3)
        log_in user
        click_link "Request Critique"
        click_button "monthly-btn"

        within("#membership_monthly") do
          fill_in "Card Number", with: "4111111111111111"
          fill_in "Expiration (MM/YYYY)", with: "01/2018"
          fill_in "Security Code", with: "124"
          click_button "Submit"
        end

        expect(page).to have_content "Submit Critique Request"
        click_link "Account Information"
        account_information = Dom::AccountInformation.first
        expect(account_information.current_subscription_plan).to eq("Monthly Subscription")
      end
    end
  end
end
