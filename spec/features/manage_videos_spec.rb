require "spec_helper"

describe "managing videos" do
  let(:user) { create(:user) }

  before do
    log_in user
    visit dashboard_path
  end

  it "a user can upload a video" do
    click_link "edit-videos"

    expect(page).to have_content("Upload Video")

    fill_in "Video", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"


    expect {
      click_button "Upload"
    }.to change {
      user.videos.count
    }.from(0).to(1)

    expect(page).to have_content("Delete")
  end

  it "a user can play uploaded videos" do

  end

  it "a user can delete a video" do
    create(:video, user: user)
    click_link "edit-videos"

    video = user.videos.first

    expect {
      video.delete
    }.to change {
      user.videos.count
    }.from(1).to(0)
  end

  it "a user can have a maximum of 10 videos" do
    create_list(:video, 9, user: user)

    click_link "edit-videos"

    expect(user.videos.count).to eq(9)

    fill_in "Video", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    click_button "Upload"

    expect(user.videos.count).to eq(10)

    expect(page).not_to have_content("Upload Videos")
  end
end