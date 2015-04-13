class Superadmin::UsersController < ApplicationController
  before_action :ensure_superadmin

  def index
    @mentors = User.talent_mentors
  end

  def edit
    @mentor = User.find(params[:id])
  end

  def update
    @mentor = User.find(params[:id])
    if @mentor.update_attributes(user_params)
      flash[:notice] = "Talent mentor successfully updated"
      redirect_to superadmin_users_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :mentor
    )
  end
end
