require "spec_helper"

feature "Critique workflow" do
  let(:user) { create(:user, 
    stripe_customer_id: "cus_47oUnsvWTQWwPs",
    stripe_plan_id: "sub_4CFLiZFRyp52ya"
  ) }

  background do
    clear_emails
  end

  scenario "allows user to submit a critique" do
    VCR.use_cassette("create_valid_stripe_critique_payment") do
      log_in user
      visit dashboard_path

      click_link "Request Critique"

      expect(page).to have_content("Critique Request")

      fill_in "critique_project_title", with: "Audition for Gossip Girl"
      select "Voice", from: "critique[types][]"
      fill_in "critique_notes", with: "What do you think I could do to improve my skills?"

      expect(page).to have_content("Choose two photos")

      attach_file "critique_headshots_attributes_0_image", "#{Rails.root}/spec/fixtures/image.jpg"
      attach_file "critique_headshots_attributes_1_image", "#{Rails.root}/spec/fixtures/image.jpg"

      expect(page).to have_content("Paste video URL")

      expect(page).to have_content("When you click Request Critique, we will charge $24.99 to the credit card you have on file from registration.")

      fill_in "critique_videos_attributes_0_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

      expect {
        click_button "Submit Critique"
      }.to change {
        Critique.count
      }.from(0).to(1)

      expect(page).to have_content("Your critique request has been sent.")
      open_email Figaro.env.castnotice_admin_email
      the_critique_url = root_url + "critiques/" + Critique.last.uuid
      expect(current_email.body).to have_content(the_critique_url)
    end
  end

  context "as a mentor" do
    let(:mentor) { create(:user, :mentor) }
    let!(:critique) { create(:critique, project_title: "OZ", types: ["dance", "voice"], notes: "Improve what?") }

    before do
      log_in mentor
    end

    scenario "can see a critique request" do
      visit critique_path(critique.uuid)
      expect(page).to have_content("Critique Requested")
      expect(page).to have_content("OZ")
      expect(page).to have_content("Improve what?")
    end

    scenario "can respond to a critique request" do
      visit critique_path(critique.uuid)
      expect(page).to have_content("Critique Requested")
      expect(page).to have_content("OZ")
      expect(page).to have_content("Dance")
      expect(page).to have_content("Voice")
      expect(page).to have_content("Improve what?")
      expect(page).to have_content("Critique Response")
      expect(page).to have_content("Please type your response here.")

      fill_in "critique_response_body", with: "Looks Great!"

      click_button "Respond"

      expect(page).to have_content("Your response has been sent.")
      expect(current_path).to eq(critiques_path)

      open_email Figaro.env.castnotice_admin_email
      expect(current_email.body).to have_content(critique_path(critique.uuid))
    end

    scenario "talent receives an email when critique request is completed" do
      visit critique_path(critique.uuid)
      fill_in "critique_response_body", with: "Looks Great!"
      click_button "Respond"

      open_email critique.user.email

      expect(current_email.body).to have_content("Your Critique Request has been completed please click the link provided to review.")
      expect(current_email.body).to have_content(critique_url(critique.uuid))
    end

    scenario "mentor can view index of available critique requests" do
      critique1 = create(:critique, project_title: "Massive")
      critique2 = create(:critique, project_title: "Big")
      critique3 = create(:critique, project_title: "Small")

      visit critiques_path
      expect(page).to have_content(critique.project_title)
      expect(page).to have_content(critique1.project_title)
      expect(page).to have_content(critique2.project_title)
      expect(page).to have_content(critique3.project_title)
    end

    scenario "critiques are closed for review when they have a response" do
      create(:critique, :closed)
      visit critiques_path

      expect(page).to have_content("Completed")
    end
  end
end
