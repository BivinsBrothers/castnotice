class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location

  def new
    if params[:mentor]
      render :mentor, locals: {resource: User.new}
    else
      super
    end
  end

  def create
    user = User.new(registration_params)

    if user.save(registration_params)
      user.create_resume
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
                   :location_city, :location_state, :location_zip, :birthday, :parent_name, :parent_email, :mentor,
                   :parent_location, :parent_location_two, :parent_city, :parent_state, :parent_zip, :parent_phone, :tos)
  end
end
