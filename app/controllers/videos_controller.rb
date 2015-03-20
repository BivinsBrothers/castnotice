class VideosController < ApplicationController
  before_action :authenticate_user!

  def new
    @video = Video.new
  end

  def index
    @video = Video.new
    @videos = current_resume.videos
  end

  def create
    if params["video"].present?
      @video = current_resume.videos.build(video_params)

      if @video.save
        redirect_to edit_resume_path(anchor: 'video-anchor')
      else
        flash[:failure] = "Sorry unable to save your Video please correct errors: #{@video.errors.full_messages.to_sentence}"
        redirect_to edit_resume_path
      end
    else
      flash[:failure] = "Select the video to be uploaded"
      redirect_to edit_resume_path
    end

  end

  def create_from_link
    if video_params["video_url"].blank?
      flash[:failure] = "Enter the URL of a Youtube or Video video page"
      redirect_to edit_resume_path
    else
      @video = current_resume.videos.build(video_params)
      if @video.save
        redirect_to edit_resume_path(anchor: 'video-anchor')
      else
        flash[:failure] = "Sorry unable to save your Video please correct errors: #{@video.errors.full_messages.to_sentence}"
        redirect_to edit_resume_path
      end
    end
  end



  def destroy
    @video = current_resume.videos.find_by_id(params[:id])

    if @video && @video.delete
      flash[:success] = "Your video was deleted"
    else
      flash[:failure] = "Video was not removed, please try again."
    end

    redirect_to edit_resume_path(anchor: 'video-anchor')
  end

  private

  def video_params
    params.require(:video).permit(:video_url, :video_thumb_url, :video)
  end
end
