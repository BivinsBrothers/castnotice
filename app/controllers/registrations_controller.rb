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
          .permit( :name, :email, :password, :password_confirmation, :location_address, :location_address_two,
                   :location_city, :location_state, :location_zip, :birthday, :parent_name, :parent_email,
                   :parent_location, :parent_location_two, :parent_city, :parent_state, :parent_zip, :parent_phone, :tos)
  end
end
