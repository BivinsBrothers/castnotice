require "spec_helper"

feature "superadmin can manage mentor" do
  let!(:user)  { create(:user) }
  let!(:mentor) { create(:user, :mentor, email: 'mentor@example.com', name: "m1") }
  let!(:mentor1) { create(:user, :mentor, email: 'mentor1@example.com', name: "m2") }
  let!(:admin)  { create(:user, :admin) }
  let!(:superadmin) { create(:user, :admin, email: 'hello@castnotice.com') }

  scenario "views list" do
    log_in user
    expect(page).not_to have_link("Mentors")
    click_link "sign out"

    log_in user
    expect(page).not_to have_link("Mentors")
    click_link "sign out"

    log_in admin
    expect(page).not_to have_link("Mentors")
    click_link "sign out"

    log_in superadmin

    within(".login") { click_link "Mentors" }
    expect(page).to have_content(mentor.email)
    expect(page).to have_content(mentor.name)
    expect(page).to have_content(mentor1.email)
    expect(page).to have_content(mentor1.name)

    within("table.standard tbody tr:first-child") do
      click_link "Edit"
    end
    uncheck "Mentor?"
    click_button "Save"

    expect(page).to have_content(mentor.email)
    expect(page).to have_content(mentor.name)
    expect(page).to_not have_content(mentor1.email)
    expect(page).to_not have_content(mentor1.name)
  end

end
