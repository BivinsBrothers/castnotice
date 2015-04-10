require "spec_helper"

feature "managing mentor" do
  it "allows a mentor to register" do
    enter_promo_code
    create(:region, name: "Central")
    create(:region, name: "Western")
    visit '/users/sign_up/mentor'

    expect(page).to have_content("Mentor Account")

    fill_in "Name", with: "Test Mentor"
    fill_in "Email", with: "mentor@fake.com"
    fill_in "Password", with: "superpass"
    fill_in "Password confirmation", with: "superpass"
    fill_in "Hometown", with: "Jacksonville"
    check "Are you a current College/University Faculty Member?"
    fill_in "College", with: "UNF"
    fill_in "Current City", with: "Chicago"
    select "Western", from: "Region"

    fill_in "user[location_address]", with: "123 Somewhere"
    fill_in "user[location_address_two]", with: "PO BOX 105"
    fill_in "user[location_city]", with: "Grand Rapids"
    select  "Michigan", from: "user[location_state]"
    fill_in "user[location_zip]", with: "49506"

    fill_in "user[mentor_bio_attributes][company]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][company_address]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][company_phone]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][past_company]", with: "A Slightly Less Special Company"
    fill_in "user[mentor_bio_attributes][current_projects]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][biography]", with: "Biography Details"
    fill_in "user[mentor_bio_attributes][teaching_experience]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][education_experience]", with: "Special Company"
    fill_in "user[mentor_bio_attributes][artistic_organizations]", with: "Special Company"

    select "17", from: "user_birthday_3i"
    select "September", from: "user_birthday_2i"
    select "1987", from: "user_birthday_1i"

    check "user_tos"

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
