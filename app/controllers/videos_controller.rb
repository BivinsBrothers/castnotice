class VideosController < ApplicationController

  def index
    @video = Video.new
    @videos = current_user.videos
  end

  def create
    current_user.videos.create(video_params)

    redirect_to videos_path
  end

  def destroy
    @video = Video.find_by_id(params[:id])

    if @video && @video.delete
      flash[:success] = "Your video was deleted"
      redirect_to videos_path
    else
      flash[:failure] = "Video was not removed, please try again."
      redirect_to videos_path
    end
  end


  private

  def video_params
    params.require(:video).
        permit(:video_url, :video_thumb_url, :user_id)
  end

end