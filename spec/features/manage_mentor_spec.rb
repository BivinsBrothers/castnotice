require "spec_helper"

describe "managing mentor" do
  it "allows a mentor to register" do
    visit users_sign_up_mentor_path

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

  it "allows mentor to view their dashboard/My Bio" do
    let(:mentor) { create(:user, :mentor) }

    log_in mentor

    visit dashboard_path

    expect(page).to have_content("My Bio")

    expect(page).to have_content("Your Photos")
    expect(page).to have_content("Current Company")
    expect(page).to have_content("Company Address")
    expect(page).to have_content("Company Phone Number")
    expect(page).to have_content("Past Companies")
    expect(page).to have_content("Current Projects")
    expect(page).to have_content("Teaching Expertise")
    expect(page).to have_content("Compa")


  end
end