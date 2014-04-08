require "spec_helper"

describe "managing resistration" do
  it "allows visitor to register" do
    visit root_path
    click_link "How it works"
    expect(page).to have_content("How it works.")
    click_link "Register Now"
    expect(page).to have_content("Password")
  end
end