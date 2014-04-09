require "spec_helper"

describe 'video_id' do
  it "extracts the youtube video id" do
    url = "http://www.youtube.com/watch?v=m8u8Z3bUQfs"
    video = FactoryGirl.build(:video, :video_url => url)
    video.youtube_id.should == 'm8u8Z3bUQfs'
  end

  it "extracts the vimeo video id" do
    url = 'http://vimeo.com/channels/staffpicks/91207483'
    video = FactoryGirl.build(:video, :video_url => url)
    video.vimeo_id.should == '91207483'
    video.save
    video.video_thumb_url.should match(/vimeo.*jpg/)
  end

  it "does not break without a url" do
    video = FactoryGirl.build(:video, :video_url => '')
    video.youtube_id.should == nil
    video.vimeo_id.should == nil
  end

  it "does not break with a bad url" do
    video = FactoryGirl.build(:video)
    video.video_url = '<a href="http://vimeo.com/9876545678">wrong</a>'
    video.youtube_id
    video.vimeo_id
    video.should_not be_valid
  end

  it "finds v param in long url" do
    url = "http://youtube.com/watch?v=9NeI0Fo1k7E&eurl=http%3A%2F%2Flocalhost%3A3000%2Fcast%2F10&feature=player_embedded"
    video = FactoryGirl.build(:video, :video_url => url)
    video.youtube_id.should == '9NeI0Fo1k7E'
  end
end