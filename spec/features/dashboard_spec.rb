require "spec_helper"

describe "user dashboard" do
  it 'allows user to view their dashboard' do
    user = create(:user)

    log_in user
    visit dashboard_path

    expect(page).to have_content("Test Dummy")
    expect(page).to have_content("Edit Personal Information")
    expect(page).to have_content("Your Head Shots")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Add Headshots")
    expect(page).to have_content("Your Videos")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Add Videos")
    expect(page).to have_content("Experience")
    expect(page).to have_content("Edit")
  end
end
