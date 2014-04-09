class VideosController < ApplicationController

  def index
    @video = Video.new
    @videos = current_user.videos
  end

  def create
    current_user.videos.create(video_params)

    redirect_to videos_path
  end


  private

  def video_params
    params.require(:video).
        permit(:video_url, :video_thumb_url, :user_id)
  end

end