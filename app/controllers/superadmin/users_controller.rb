class Superadmin::UsersController < ApplicationController
  before_action :ensure_superadmin

  def index
    @account_type = params[:type]
    if @account_type == "admins"
      @users = User.admins.decorate
    elsif @account_type == "mentors"
      @users = User.talent_mentors.decorate
    else
      @users = User.all.order("email").decorate
    end
  end

  def edit
    @user = User.find(params[:id]).decorate
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
      :name, :email, :mentor, :admin, :location_address,
      :location_address_two, :location_city, :location_state,
      :location_zip, :parent_name, :parent_email,
      :parent_location, :parent_location_two, :parent_city,
      :parent_state, :parent_zip, :parent_phone)
  end
end
