class RegistrationsController < Devise::RegistrationsController

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

  def create
    user = User.new(user_params)

    if user.save(user_params)
      sign_in(user)
      redirect_to :dashboard
    else
      @user = user
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation, :location_address,
                  :location_city, :location_state, :location_zip, :birthday, :tos)
  end
end
