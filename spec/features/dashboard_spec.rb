require "spec_helper"

describe "user dashboard" do
  it 'allows user to view their dashboard' do
    user = create(:user)

    log_in user
    visit dashboard_path

    expect(page).to have_content("My Stage: Test Dummy")
    expect(page).to have_content("Now starring you.")
    expect(page).to have_content("Edit Resume")
    expect(page).to have_content("Your Head Shots")
    expect(page).to have_content("Your Videos")
  end
end
