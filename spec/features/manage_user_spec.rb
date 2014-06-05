require "spec_helper"

describe "managing user" do
  context "when registering a user" do
    before(:each) do
      # use_vcr_cassette "feature_stripe_customer_create_and_payment"
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
    end

    vcr_options = { cassette_name: "feature_stripe_customer_create_and_payment" }

    it "allows a user to register", vcr: vcr_options do
      visit new_user_registration_path(account_type: "annual")

      expect(current_path).to eq(new_user_registration_path(account_type: Stripe::Plans::ANNUAL))

      birthday = 31.years.ago

      fill_in "Full Name", with: "Test Dummy"
      fill_in "Email", with: "dummy@test.me"
      fill_in "Password", with: "superpass"
      fill_in "Password confirmation", with: "superpass"

      fill_in "Address One", with: "123 Somewhere"
      fill_in "Address Two", with: "PO BOX 105"
      fill_in "City", with: "Grand Rapids"
      select  "Michigan", from: "State"
      fill_in "Zip Code", with: "49506"

      select birthday.day.to_s, from: "user_birthday_3i"
      select birthday.strftime("%B"), from: "user_birthday_2i"
      select birthday.year.to_s, from: "user_birthday_1i"

      fill_in "Card Number", with: "4242424242424242"
      fill_in "Expiration (MM/YYYY)", with: "01/2017"

      check "Accept our Terms of Service"

      click_button "Sign up"

      sleep 5

      expect(page).to have_content("Hello Test Dummy")

      click_link("Account Information")

      account_information = Dom::AccountInformation.first

      expect(account_information.current_subscription_plan).to eq("Annual Subscription")
      expect(account_information.full_name).to eq("Test Dummy")
      expect(account_information.email).to eq("dummy@test.me")

      expect(account_information.location_address).to eq("123 Somewhere")
      expect(account_information.location_address_two).to eq("PO BOX 105")
      expect(account_information.location_city).to eq("Grand Rapids")
      expect(account_information.location_state).to eq("MI")
      expect(account_information.location_zip).to eq("49506")

      expect(account_information.birthday_day).to eq(birthday.day.to_s)
      expect(account_information.birthday_month).to eq(birthday.month.to_s)
      expect(account_information.birthday_year).to eq(birthday.year.to_s)
    end

    it "shows parent questions when minor is registering", vcr: vcr_options do
      visit new_user_registration_path(account_type: "annual")

      expect(current_path).to eq(new_user_registration_path(account_type: Stripe::Plans::ANNUAL))

      birthday = 7.years.ago

      fill_in "Full Name", with: "Test Dummy"
      fill_in "Email", with: "dummy@test.me"
      fill_in "Password", with: "superpass"
      fill_in "Password confirmation", with: "superpass"

      fill_in "Address One", with: "123 Somewhere"
      fill_in "Address Two", with: "PO BOX 105"
      fill_in "City", with: "Grand Rapids"
      select  "Michigan", from: "State"
      fill_in "Zip Code", with: "49506"

      select birthday.day.to_s, from: "user_birthday_3i"
      select birthday.strftime("%B"), from: "user_birthday_2i"
      select birthday.year.to_s, from: "user_birthday_1i"

      fill_in "Parents Fullname", with: "Mommy Dummy"
      fill_in "Parents Email", with: "mommydummy@fake.com"
      fill_in "Parents Street Address", with: "456 Somewhere Else"
      fill_in "Parents Suite/Apt", with: "PO BOX 205"
      fill_in "Parents City", with: "Grand Rapids"
      select  "Michigan", from: "user[parent_state]"
      fill_in "Parents Zip Code", with: "49506"
      fill_in "Parents Phone", with: "616-234-4567"

      fill_in "Card Number", with: "4242424242424242"
      fill_in "Expiration (MM/YYYY)", with: "01/2017"

      check "Accept our Terms of Service"

      click_button "Sign up"

      sleep 5

      expect(page).to have_content("Hello Test Dummy")

      click_link("Account Information")

      account_information = Dom::AccountInformation.first

      expect(account_information.current_subscription_plan).to eq("Annual Subscription")
      expect(account_information.full_name).to eq("Test Dummy")
      expect(account_information.email).to eq("dummy@test.me")

      expect(account_information.location_address).to eq("123 Somewhere")
      expect(account_information.location_address_two).to eq("PO BOX 105")
      expect(account_information.location_city).to eq("Grand Rapids")
      expect(account_information.location_state).to eq("MI")
      expect(account_information.location_zip).to eq("49506")

      expect(account_information.birthday_day).to eq(birthday.day.to_s)
      expect(account_information.birthday_month).to eq(birthday.month.to_s)
      expect(account_information.birthday_year).to eq(birthday.year.to_s)

      expect(account_information.parent_name).to eq("Mommy Dummy")
      expect(account_information.parent_email).to eq("mommydummy@fake.com")

      expect(account_information.parent_location).to eq("456 Somewhere Else")
      expect(account_information.parent_location_two).to eq("PO BOX 205")
      expect(account_information.parent_city).to eq("Grand Rapids")
      expect(account_information.parent_state).to eq("MI")
      expect(account_information.parent_zip).to eq("49506")
      expect(account_information.parent_phone).to eq("616-234-4567")
    end

    it "allows user to edit Account Information" do
      birthday = 27.years.ago
      user = create(:user, birthday: birthday)

      log_in user
      visit dashboard_path

      click_link "Account Information"

      expect(page).to_not have_content("Parent Fullname")

      expect(find_field("Name").value).to eq("Test Dummy")
      expect(find_field("Email").value).to eq(user.email)
      expect(find_field("user_birthday_1i").value).to eq(birthday.year.to_s)
      expect(find_field("user_birthday_2i").value).to eq(birthday.month.to_s)
      expect(find_field("user_birthday_3i").value).to eq(birthday.day.to_s)

      fill_in "Full Name", with: "My Cool New Name"
      fill_in "Address One", with: "3333 Lady Dr."
      fill_in "Address Two", with: "APT. 109"
      fill_in "City",with: "Grand Rapids"
      select  "Michigan", from: "user[location_state]"
      fill_in "Zip Code", with: "49505"

      select "17", from: "user_birthday_3i"
      select "September", from: "user_birthday_2i"
      select "2014", from: "user_birthday_1i"

      fill_in "Parents Fullname", with: "Mommy Dummy"
      fill_in "Parents Email", with: "mommydummy@fake.com"
      fill_in "Parents Street Address", with: "456 Somewhere Else"
      fill_in "Parents Suite/Apt", with: "PO BOX 205"
      fill_in "Parents City", with: "Grand Rapids"
      select  "Michigan", from: "user[parent_state]"
      fill_in "Parents Zip Code", with: "49506"
      fill_in "Parents Phone", with: "616-234-4657"

      click_button "Save"

      expect(page).to have_content("Hello My Cool New Name")

      click_link "Account Information"

      expect(find_field("Address One").value).to eq("3333 Lady Dr.")
      expect(find_field("Address Two").value).to eq("APT. 109")
      expect(find_field("City").value).to eq("Grand Rapids")
      expect(find_field("Zip Code").value).to eq("49505")
    end
  end

  it "displays validation errors for required attributes on a user" do
    user = create(:user)

    log_in user
    visit edit_accounts_path(user)

    fill_in "Full Name", with: ""
    fill_in "Email", with: ""
    click_button "Save"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Name can't be blank")
  end

  it "allows a user to request a new password" do
    user = create(:user)

    visit new_user_session_path

    click_link "Forgot your password?"

    fill_in "Email", with: user.email
    click_button "Send me reset password instructions"

    open_email user.email

    expect(current_email).to have_content("Change my password")
  end

  it "allows a mentor to register" do
    visit new_user_registration_path(account_type: "mentor")

    expect(page).to have_content("Mentor Account")

    fill_in "Name", with: "Test Mentor"
    fill_in "Email", with: "mentor@fake.com"
    fill_in "Password", with: "superpass"
    fill_in "Password confirmation", with: "superpass"

    fill_in "user[location_address]", with: "123 Somewhere"
    fill_in "user[location_address_two]", with: "PO BOX 105"
    fill_in "user[location_city]", with: "Grand Rapids"
    select  "Michigan", from: "user[location_state]"
    fill_in "user[location_zip]", with: "49506"

    select "17", from: "user_birthday_3i"
    select "September", from: "user_birthday_2i"
    select "1987", from: "user_birthday_1i"

    check "Accept our Terms of Service"

    expect {
      click_button "Sign up"
    }.to change {
      User.count
    }.from(0).to(1)

    expect(current_path).to eq(dashboard_path)

    user = User.last

    expect(user.name).to eq("Test Mentor")

    expect(user.mentor).to eq(true)
  end
end
