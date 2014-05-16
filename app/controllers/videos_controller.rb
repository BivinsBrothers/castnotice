class VideosController < ApplicationController

  def new
    @video = Video.new
  end

  def index
    @video = Video.new
    @videos = current_resume.videos
  end

  def create
    @video = current_resume.videos.build(video_params)
    if @video.save
    else
      flash[:failure] = "Sorry unable to save your Video please correct errors: #{@video.errors.full_messages.to_sentence}"
    end
    redirect_to edit_resume_path
  end

  def destroy
    @video = current_resume.videos.find_by_id(params[:id])

    if @video && @video.delete
      flash[:success] = "Your video was deleted"
    else
      flash[:failure] = "Video was not removed, please try again."
    end
    redirect_to edit_resume_path
  end


  private

  def video_params
    params.require(:video).
        permit(:video_url, :video_thumb_url, :user_id)
  end

end
