class HeadshotsController < ApplicationController
  before_action :authenticate_user!

  def new
    @headshot = Headshot.new
  end

  def index
    @headshots = current_resume.headshots
    @headshot = Headshot.new
  end

  def create
    @headshot = current_resume.headshots.build(headshot_params)
    if @headshot.save
      redirect_to edit_resume_path + '#photo-anchor'
    else
      flash[:failure] = "Sorry unable to save your Head Shot please correct errors: #{@headshot.errors.full_messages.to_sentence}"
      redirect_to edit_resume_path
    end
  end

  def update
    @headshot = current_resume.headshots.find(params[:id])

    case params[:background]
    when "true"
      @headshot.set_as_background_image
    when "false"
      @headshot.remove_as_background_image
    end

    case params[:resume_photo]
    when "true"
      @headshot.set_as_resume_photo
    when "false"
      @headshot.remove_as_resume_photo
    end

    redirect_to edit_resume_path + '#photo-anchor'
  end

  def destroy
    headshot = current_resume.headshots.find(params[:id])
    headshot.destroy

    redirect_to edit_resume_path + '#photo-anchor'
  end

  private

  def headshot_params
    params.require(:headshot).permit(:image, :image_cache)
  end
end
