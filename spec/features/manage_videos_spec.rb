require "spec_helper"

describe "managing videos" do
  let(:user) { create(:user) }

  before do
    log_in user
    visit dashboard_path
  end

  it "a user can upload a video" do
    click_link "edit-videos"

    expect(page).to have_content("Add a video")

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"


    expect {
      click_button "Upload Video"
    }.to change {
      user.videos.count
    }.from(0).to(1)

    expect(page).to have_content("Delete")
  end

  it "a user can delete a video" do
    create(:video, user: user)
    click_link "edit-videos"

    click_link "Delete"

    expect(user.videos.count).to eq(0)
  end

  it "a user can have a maximum of 5 videos" do
    create_list(:video, 4, user: user)

    click_link "edit-videos"

    expect(user.videos.count).to eq(4)

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    click_button "Upload Video"

    expect(user.videos.count).to eq(5)

    expect(page).not_to have_content("Add a video")
    expect(page).to have_content("Maximum videos please delete to add.")
  end
end