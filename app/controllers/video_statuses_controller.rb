class VideoStatusesController < ActionController::Base

  def notify
    if video = Video.where(video_job_id: params[:job][:id]).first
      video.update_attributes(
        video_job_status: params[:job][:state],
        video_height:     params[:input][:height],
        video_width:      params[:input][:width],
      )
    end

    render nothing: true, status: 200
  end

end
