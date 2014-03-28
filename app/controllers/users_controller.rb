class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(:name, :email, :location_address, :location_city, :location_state, :location_zip, :birthday, :image, :image_cache)
  end
end