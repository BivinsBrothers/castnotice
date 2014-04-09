class RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new(registration_params)

    if user.save(registration_params)
      sign_in(user)
      redirect_to :dashboard
    else
      @user = user
      render :new
    end
  end

  private

  def registration_params
    params.require(:user)
          .permit( :name, :email, :password, :password_confirmation, :location_address, :location_city, :location_state, :location_zip, :birthday, :tos)
  end
end
