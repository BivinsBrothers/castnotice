require "spec_helper"

feature "Critique workflow" do
  let(:user) { create(:user) }

  scenario "allows user to submit a critique" do
    log_in user
    visit dashboard_path

    click_link "Create Critique Request"

    expect(page).to have_content("Critique Request")

    fill_in "critique_project_title", with: "Audition for Gossip Girl"
    fill_in "critique_notes", with: "What do you think I could do to improve my skills?"

    expect(page).to have_content("Choose two photos")

    attach_file "critique_headshots_attributes_0_image", "#{Rails.root}/spec/fixtures/image.jpg"
    attach_file "critique_headshots_attributes_1_image", "#{Rails.root}/spec/fixtures/image.jpg"

    expect(page).to have_content("Paste video URL")

    fill_in "critique_videos_attributes_0_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    expect {
      click_button "Submit Critique"
    }.to change {
      Critique.count
    }.from(0).to(1)

    expect(page).to have_content("Your critique request has been sent.")

    open_email Figaro.env.castnotice_admin_email
    the_critique_url = root_url + "critiques/" + Critique.last.uuid
    expect(current_email).to have_content(the_critique_url)
  end

  context "as a mentor" do
    let(:mentor) { create(:user, :mentor) }
    let!(:critique) { create(:critique, project_title: "OZ", notes: "Improve what?") }

    before do
      log_in mentor

      visit critique_path(critique.uuid)
    end

    scenario "can see a critique request" do
      expect(page).to have_content("Critique Requested")
      expect(page).to have_content("OZ")
      expect(page).to have_content("Improve what?")
    end

    scenario "can respond to a critique request" do
      expect(page).to have_content("Critique Requested")
      expect(page).to have_content("OZ")
      expect(page).to have_content("Improve what?")
      expect(page).to have_content("Critique Response")
      expect(page).to have_content("Please type your response here.")

      fill_in "critique_response_body", with: "Looks Great!"

      click_button "Respond"

      expect(page).to have_content("Your response has been sent.")
      expect(page).to have_content("Hello Test Dummy")

      open_email Figaro.env.castnotice_admin_email
      expect(current_email).to have_content(critique_path(critique.uuid))

      visit critique_path(critique.uuid)

      expect(page).to have_content("Critique Response")
      expect(page).to_not have_content("Please type your response here.")
    end

    scenario "talent receives an email when critique request is completed" do
      fill_in "critique_response_body", with: "Looks Great!"
      click_button "Respond"

      open_email critique.user.email

      expect(current_email).to have_content("Your Critique Request has been completed please click the link provided to review.")
      expect(current_email).to have_content(critique_url(critique.uuid))

      visit critique_path(critique.uuid)

      expect(page).to have_content("Looks Great!")
    end
  end
end
