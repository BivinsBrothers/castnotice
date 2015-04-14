class Superadmin::UsersController < ApplicationController
  before_action :ensure_superadmin

  def index
    @account_type = params[:type]
    if @account_type == "admins"
      @users = User.admins
    elsif @account_type == "mentors"
      @users = User.talent_mentors
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to :back
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :mentor,
      :admin
    )
  end
end
