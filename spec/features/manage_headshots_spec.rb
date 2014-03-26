require "spec_helper"

describe "managing headshots" do
  let(:user) { create(:user) }

  before do
    log_in user
    visit dashboard_path
  end

  after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/#{HeadshotUploader.store_dir}"])
    FileUtils.rm_rf(Dir["#{HeadshotUploader.cache_dir}"])
  end

  it "a user can upload a headshot" do
    click_link "edit-headshots"

    attach_file "Image", "#{Rails.root}/spec/fixtures/image.jpg"

    expect {
      click_button "Upload"
    }.to change {
      Dom::Headshots.all.count
    }.from(0).to(1)
  end

  it "a user can delete a headshot" do
    create(:headshot, user: user)
    click_link "edit-headshots"

    headshot = Dom::Headshots.first

    expect {
      headshot.delete!
    }.to change {
      Dom::Headshots.all.count
    }.from(1).to(0)
  end

  it "a user can select a background from headshots" do
    create(:headshot, user: user)
    click_link "edit-headshots"

    headshot = Dom::Headshots.first
    headshot.set_as_background

    expect(headshot.background?).to be_true
  end

  it "a user can remove the currently selected background" do
    headshot = create(:headshot, user: user)
    user.update_attributes!(background_image: headshot)

    click_link "edit-headshots"

    expect(page).to have_content("Remove")

    expect {
      click_link "Remove"
    }.to change {
      Dom::Headshots.first.background?
    }.from(true).to(false)
  end

  context "when a user deletes the current background head shot" do
    it "sets user background image to nil" do
      headshot = create(:headshot, user: user)
      user.update_attributes!(background_image: headshot)

      click_link "edit-headshots"

      expect {
        Dom::Headshots.first.delete!
      }.to change {
        user.reload.background_image_id
      }.from(headshot.id).to(nil)
    end
  end


  it "a user can have a maximum of 10 headshots" do
    create_list(:headshot, 9, user: user)

    click_link "edit-headshots"

    expect(Dom::Headshots.all.count).to eq(9)

    attach_file "Image", "#{Rails.root}/spec/fixtures/image.jpg"
    click_button "Upload"

    expect(Dom::Headshots.all.count).to eq(10)

    expect(page).not_to have_content("Upload Head Shot")
  end
end