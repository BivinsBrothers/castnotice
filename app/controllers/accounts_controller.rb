class AccountsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(account_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def account_params
    params.require(:user)
    .permit(:name, :email, :location_address, :location_address_two, :location_city, :location_state, :location_zip, :birthday, :tos)
  end
end