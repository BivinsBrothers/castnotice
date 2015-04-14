require 'spec_helper'

describe "admin registration" do
  it "allows a user to register" do
    visit new_user_registration_path(account_type: "new_admin")

    expect(current_path).to eq(new_user_registration_path(account_type: "new_admin"))

    birthday = 31.years.ago

    fill_in "Full Name", with: "Test Dummy"
    fill_in "Email", with: "dummy@test.me"
    fill_in "Password", with: "superpass"
    fill_in "Password confirmation", with: "superpass"

    select birthday.day.to_s, from: "user_birthday_3i"
    select birthday.strftime("%B"), from: "user_birthday_2i"
    select birthday.year.to_s, from: "user_birthday_1i"
    check "user_tos"

    click_button "Sign up"

    expect(page).to have_content("Hello Test Dummy")

    click_link("Account Information")

    account_information = Dom::AccountInformation.first

    expect(account_information.admin_account).to eq("Admin")
    expect(account_information.full_name).to eq("Test Dummy")
    expect(account_information.email).to eq("dummy@test.me")

    expect(account_information.birthday_day).to eq(birthday.day.to_s)
    expect(account_information.birthday_month).to eq(birthday.month.to_s)
    expect(account_information.birthday_year).to eq(birthday.year.to_s)
  end

end
