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


    attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"

    expect {
      click_button "Upload Head Shot"
    }.to change {
      user.headshots.count
    }.from(0).to(1)
  end

  it "a user can delete a headshot" do
    create(:headshot, user: user)
    click_link "edit-headshots"

    headshot = user.headshots.first

    expect {
      headshot.delete
    }.to change {
      user.headshots.count
    }.from(1).to(0)
  end

  it "a user can select a background from headshots" do
    create(:headshot, user: user)
    click_link "edit-headshots"

    expect {
      click_link "Set as background"
    }.to change {
      user.headshots.first.background?
    }.from(false).to(true)
  end

  it "a user can remove the currently selected background" do
    headshot = create(:headshot, user: user, background: true)

    click_link "edit-headshots"

    expect(page).to have_content("Remove")

    expect {
      click_link "Remove"
    }.to change {
      user.headshots.first.background?
    }.from(true).to(false)
  end

  it "a user can have a maximum of 10 headshots" do
    create_list(:headshot, 9, user: user)

    click_link "edit-headshots"

    expect(user.headshots.count).to eq(9)

    attach_file "headshot_image", "#{Rails.root}/spec/fixtures/image.jpg"
    click_button "Upload Head Shot"

    expect(user.headshots.count).to eq(10)

    expect(page).not_to have_content("Add Head Shot")
  end
end