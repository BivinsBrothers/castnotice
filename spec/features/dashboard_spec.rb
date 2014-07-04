require "spec_helper"

feature "user dashboard" do
  it "allows user to view their dashboard" do
    user = create(:user)

    log_in user
    visit dashboard_path

    expect(page).to have_content("Hello Test Dummy")
    expect(page).to have_content("My Close Up")
    expect(page).to have_content("Edit Resume")
    expect(page).to have_content("Your Photos")
    expect(page).to have_content("Your Videos")
  end

  it "sends birthday wishes on users birthday" do
    user = create(:user, :with_parent, birthday: Date.current)

    log_in user
    visit dashboard_path
    expect(page).to have_content("Happy Birthday!")
  end
end
