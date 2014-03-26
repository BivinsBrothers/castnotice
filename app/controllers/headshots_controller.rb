class HeadshotsController < ApplicationController
  def index
    @headshot = Headshot.new
  end

  def create
    current_user.headshots.create(headshot_params)

    redirect_to headshots_path
  end

  def update
    case params[:background].to_sym
    when :true
      headshot = current_user.headshots.find(params[:id])
      current_user.update_attributes!(background_image: headshot)
    when :false
      current_user.update_attributes!(background_image: nil)
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
