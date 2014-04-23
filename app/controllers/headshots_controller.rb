class HeadshotsController < ApplicationController

  def new
    @headshot = Headshot.new
  end

  def index
    @headshots = current_user.headshots
    @headshot = Headshot.new
  end

  def create
    @headshot = current_user.headshots.build(headshot_params)
    if @headshot.save
      redirect_to edit_resume_path
    else
      flash[:failure] = "Sorry unable to save your Head Shot please correct errors:
        #{@headshot.errors.full_message.to_sentence}"
      redirect_to edit_resume_path
    end
  end

  def update
    @headshot = current_user.headshots.find(params[:id])

    case params[:background]
    when "true"
      @headshot.set_as_background_image
    when "false"
      @headshot.remove_as_background_image
    end

    redirect_to edit_resume_path
  end

  def destroy
    headshot = current_user.headshots.find(params[:id])
    headshot.destroy

    redirect_to edit_resume_path
  end

  private

  def headshot_params
    params.require(:headshot).
    permit(:image, :image_cache, :user_id)
  end
end
