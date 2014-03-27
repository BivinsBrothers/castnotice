class HeadshotsController < ApplicationController
  def index
    @headshots = current_user.headshots
    @headshot = Headshot.new
  end

  def create
    current_user.headshots.create(headshot_params)

    redirect_to headshots_path
  end

  def update
    headshot = current_user.headshots.find(params[:id])

    case params[:background].to_sym
    when :true
      headshot.set_as_background_image
    when :false
      headshot.remove_as_background_image
    end

    redirect_to headshots_path
  end

  def destroy
    headshot = current_user.headshots.find(params[:id])
    headshot.destroy

    redirect_to headshots_path
  end

  private

  def headshot_params
    params.require(:headshot).
    permit(:image, :image_cache, :user_id)
  end
end
