require "spec_helper"

feature "registration", js: true do
  scenario "a visitor to register with an annual subscription plan" do
    VCR.use_cassette("feature_stripe_customer_create_and_payment") do
      proxy.stub("https://api.stripe.com:443/v1/tokens").and_return( Proc.new { |params, headers, body|
        # todo: Figure out how to make this dynamic based on cached value
        {
          :method => "get",
          :callback => params["sjsonp"].first,
          :jsonp => {
            id: "tok_1049GU41K0MV6J6EuhhiXb7R",
            livemode: false,
            created: 1401725225,
            used: false,
            object: "token",
            type: "card",
            card: {
              id: "card_1049GU41K0MV6J6Es7MuhuCy",
              object: "card",
              last4: "4242",
              type: "Visa",
              exp_month: 1,
              exp_year: 2017,
              fingerprint: "BuGq8s8XZQ7sYxMZ",
              country: "US",
              name: nil,
              address_line1: nil,
              address_line2: nil,
              address_city: nil,
              address_state: nil,
              address_zip: nil,
              address_country: nil,
              customer: nil
            }
          }
        }
      })
      visit root_path

      click_link "register"
      find(".register-annual").click

      expect(current_path).to eq(new_user_registration_path(stripe_plan: Stripe::Plans::ANNUAL))

      fill_in "Full Name", with: "Joe Bredow"
      fill_in "Email", with: "joe123@test.com"
      fill_in "Password", with: "1q2w3e4r"
      fill_in "Password confirmation", with: "1q2w3e4r"
      fill_in "Address One", with: "1234 Test Ln"
      fill_in "City", with: "Holland"
      select "Michigan", from: "State"
      fill_in "Zip code", with: "49423"
      select "1968", from: "user_birthday_1i"
      select "March", from: "user_birthday_2i"
      select "14", from: "user_birthday_3i"

      fill_in "Card Number", with: "4242424242424242"
      fill_in "Expiration (MM/YYYY)", with: "01/2017"

      check "Accept our Terms of Service"

      click_button "Sign up"

      sleep 5

      expect(page).to have_content("Hello Joe Bredow")

      expect(current_path).to eq(dashboard_path)

      click_link "Account Information"

      expect(page).to have_content("Plan Level: Annual Subscription")
    end
  end
end
