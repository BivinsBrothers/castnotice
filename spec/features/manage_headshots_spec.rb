require "spec_helper"

describe "managing headshots" do
  context "when a user is logged in" do
    let!(:resume) { create(:resume) }
    let(:user) { resume.user }

    before do
      log_in user
      visit dashboard_path
    end

    after(:all) do
      FileUtils.rm_rf(Dir["#{Rails.root}/public/#{HeadshotUploader.store_dir}"])
      FileUtils.rm_rf(Dir["#{HeadshotUploader.cache_dir}"])
    end

    it "a user can upload a headshot", :js => true do
      click_link "edit-headshots"
      click_link "Add a photo"

      attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"

      expect {
        click_button "Save Photo"
      }.to change {
        resume.headshots.count
      }.from(0).to(1)
    end

    it "a user can delete a headshot" do
      create(:headshot, resume: resume)
      click_link "edit-headshots"

      expect {
        click_link "Delete"
      }.to change {
        resume.headshots.count
      }.from(1).to(0)
    end

    it "a user can select a background from headshots" do
      headshot = create(:headshot, resume: resume)
      click_link "edit-headshots"

      expect {
        click_link "Set as background"
      }.to change {
        headshot.reload.background?
      }.from(false).to(true)
    end

    it "a user can select a resume photo from headshots" do
      headshot = create(:headshot, resume: resume)
      click_link "edit-headshots"

      expect {
        click_link "Set as resume photo"
      }.to change {
        headshot.reload.resume_photo?
      }.from(false).to(true)
    end

    it "a user can remove the currently selected background" do
      headshot = create(:headshot, resume: resume, background: true)
      click_link "edit-headshots"

      expect(page).to have_content("Remove")

      expect {
        click_link "Remove"
      }.to change {
        headshot.reload.background?
      }.from(true).to(false)
    end

    it "a user can have a maximum of 10 headshots", :js => true do
      create_list(:headshot, 9, resume: resume)

      click_link "edit-headshots"
      click_link "Add a photo"

      expect(resume.headshots.count).to eq(9)

      attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"
      click_button "Save Photo"

      expect(resume.headshots.count).to eq(10)

      expect(page).not_to have_content("Add a photo")
    end
  end

  context "when a user is not logged in" do
    before do
      enter_promo_code
    end
    it "they are redirected to the login page" do
      visit dashboard_path

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
