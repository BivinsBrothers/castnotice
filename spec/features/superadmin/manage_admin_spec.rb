require "spec_helper"

feature "superadmin can manage admin" do
  let!(:user)  { create(:user) }
  let!(:admin) { create(:user, :admin, email: 'myadmin@example.com', name: "m1") }
  let!(:admin1) { create(:user, :admin, email: 'admin1@example.com', name: "m2") }
  let!(:mentor)  { create(:user, :mentor) }
  let!(:superadmin) { create(:user, :admin, email: 'hello@castnotice.com') }

  scenario "views list" do
    log_in user
    expect(page).not_to have_link("Admins")
    click_link "sign out"

    log_in mentor
    expect(page).not_to have_link("Admins")
    click_link "sign out"

    log_in admin
    expect(page).not_to have_link("Admins")
    click_link "sign out"

    log_in superadmin

    within(".login") { click_link "Admins" }
    expect(page).to have_content(admin.email)
    expect(page).to have_content(admin.name)
    expect(page).to have_content(admin1.email)
    expect(page).to have_content(admin1.name)

    within("table.standard tbody tr:first-child") do
      click_link "Edit"
    end
    uncheck "Admin?"
    click_button "Save"

    within(".login") { click_link "Admins" }
    expect(page).to have_content(admin.email)
    expect(page).to have_content(admin.name)
    expect(page).to_not have_content(admin1.email)
    expect(page).to_not have_content(admin1.name)
  end

end
