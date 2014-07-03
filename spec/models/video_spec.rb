require "spec_helper"

describe 'video_id' do
  it "extracts the youtube video id" do
    url = "http://www.youtube.com/watch?v=m8u8Z3bUQfs"
    video = FactoryGirl.build(:video, :video_url => url)
    expect(video.youtube_id).to eq('m8u8Z3bUQfs')
  end

  it "extracts the vimeo video id" do
    url = 'http://vimeo.com/channels/staffpicks/91207483'
    video = FactoryGirl.build(:video, :video_url => url)
    expect(video.vimeo_id).to eq('91207483')
    video.save
    expect(video.video_thumb_url).to match(/vimeo.*jpg/)
  end

  it "does not break without a url" do
    video = FactoryGirl.build(:video, :video_url => '')
    expect(video.youtube_id).to be_nil
    expect(video.vimeo_id).to be_nil
  end

  it "does not break with a bad url" do
    video = FactoryGirl.build(:video)
    video.video_url = '<a href="http://vimeo.com/9876545678">wrong</a>'
    video.youtube_id
    video.vimeo_id
    expect(video).not_to be_valid
  end

  it "finds v param in long url" do
    url = "http://youtube.com/watch?v=9NeI0Fo1k7E&eurl=http%3A%2F%2Flocalhost%3A3000%2Fcast%2F10&feature=player_embedded"
    video = FactoryGirl.build(:video, :video_url => url)
    expect(video.youtube_id).to eq('9NeI0Fo1k7E')
  end
end
