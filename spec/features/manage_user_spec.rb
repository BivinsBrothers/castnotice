require "spec_helper"

describe "managing user" do
  it "allows a user to register" do
    visit new_user_registration_path

    fill_in "Name", with: "Test Dummy"
    fill_in "Email", with: "test@fake.com"
    fill_in "Password", with: "superpass"
    fill_in "Password confirmation", with: "superpass"

    fill_in "user[location_address]", with: "123 Somewhere"
    fill_in "user[location_city]", with: "Grand Rapids"
    select  "Michigan", from: "user[location_state]"
    fill_in "user[location_zip]", with: "49506"

    select "17", from: "user_birthday_3i"
    select "September", from: "user_birthday_2i"
    select "1987", from: "user_birthday_1i"

    check "Accept our Terms of Service"

    # TODO: need to implement credit card form

    expect {
      click_button "Sign up"
    }.to change {
      User.count
    }.from(0).to(1)

    expect(page).to have_content("Dashboard")

    user = User.last

    expect(user.name).to eq("Test Dummy")
    expect(user.email).to eq("test@fake.com")

    expect(user.location_address).to eq("123 Somewhere")
    expect(user.location_city).to eq("Grand Rapids")
    expect(user.location_state).to eq("MI")
    expect(user.location_zip).to eq("49506")

    expect(user.birthday).to eq(Date.new(1987, 9, 17))
  end

  it "allows user to edit Account Information" do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link "Account Information"

    expect(find_field("Name").value).to eq("Test Dummy")
    expect(find_field("Email").value).to eq("test@fake.com")
    expect(find_field("user_birthday_1i").value).to eq("1969")
    expect(find_field("user_birthday_2i").value).to eq("1")
    expect(find_field("user_birthday_3i").value).to eq("1")

    fill_in "Street", with: "3333 Lady Dr."
    fill_in "City", with: "Grand Rapids"
    select  "Michigan", from: "user[location_state]"
    fill_in "Zip Code", with: "49505"

    click_button "Save"

    expect(page).to have_content("Edit")
  end

  it "displays validation errors for required attributes on a user" do
    user = create(:user)

    log_in user
    visit dashboard_path

    click_link "Account Information"

    fill_in "Name", with: ""
    fill_in "Email", with: ""

    click_button "Save"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Name can't be blank")
  end
end