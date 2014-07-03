require "spec_helper"

feature "managing videos", :js => true do
  let!(:resume) { create(:resume) }
  let(:user) { resume.user }

  before do
    log_in user
    visit dashboard_path
  end

  it "a user can upload a video", :js => true do

    click_link 'dashboard-edit-resume'
    click_link "Add a video"

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"


    expect {
      click_button "Save Video"
    }.to change {
      resume.videos.count
    }.from(0).to(1)

    expect(page).to have_content("Delete")
  end

  it "a user can delete a video" do
    create(:video, resume: resume)
    click_link 'dashboard-edit-resume'

    click_link "Delete"

    expect(resume.videos.count).to eq(0)
  end

  it "a user can have a maximum of 8 videos", :js => true do
    create_list(:video, 7, resume: resume)

    click_link 'dashboard-edit-resume'
    click_link "Add a video"

    expect(resume.videos.count).to eq(7)

    fill_in "video_video_url", with: "http://www.youtube.com/watch?v=2kn8im8XOwM"

    click_button "Save Video"

    expect(resume.videos.count).to eq(8)

    expect(page).not_to have_content("Add a video")
    expect(page).to have_content("You have already uploaded the maximum videos, please delete and existing video to add a new one.")
  end
end
