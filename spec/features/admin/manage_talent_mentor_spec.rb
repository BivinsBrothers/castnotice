require "spec_helper"

feature "an admin can manage mentor" do
  let!(:user)  { create(:user) }
  let!(:mentor) { create(:user, :mentor, email: 'mentor@example.com') }
  let!(:mentor1) { create(:user, :mentor, email: 'mentor1@example.com') }
  let!(:admin)  { create(:user, :admin) }

  scenario "views list" do
    log_in user
    expect(page).not_to have_link("Mentors")
    click_link "sign out"

    log_in user
    expect(page).not_to have_link("Mentors")
    click_link "sign out"

    log_in admin
    within(".login") { click_link "Mentors" }
    expect(page).to have_content(mentor.email)
    expect(page).to have_content(mentor.name)
    expect(page).to have_content(mentor1.email)
    expect(page).to have_content(mentor1.name)
  end

end
