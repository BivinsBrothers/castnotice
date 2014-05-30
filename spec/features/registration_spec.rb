require "spec_helper"

feature "registration", js: true do
  scenario "a visitor to register with an annual subscription plan" do
    VCR.use_cassette("feature_stripe_customer_create_and_payment", record: :all) do
      proxy.cache.with_scope "feature_stripe_customer_create_and_payment" do
        visit root_path

        click_link "register"
        find(".register-annual").click

        expect(current_path).to eq(new_user_registration_path)

        fill_in "Full Name", with: "Joe Bredow"
        fill_in "Email", with: "joe@test.com"
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
        proxy.cache.use_default_scope
      end
    end
  end
  scenario "a visitor to register with a monthly subscription plan"
  scenario "a visitor to register with a broadway breakthrough annual subscription"
  scenario "a visitor can register with promo code"
end
