class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location

  def new
    if params[:mentor]
      render :mentor, locals: {resource: User.new}
    else
      super
    end
  end

  def new
    @stripe_plan = params[:stripe_plan]
    super
  end

  def create
    result = CreateUserAndStripeCustomer.perform(
      user_attributes: registration_params,
      stripe_token: params[:stripe_token],
      stripe_plan: params[:stripe_plan]
    )
    if result.success?
      sign_in result.context[:user]
      redirect_to dashboard_path
    else
      @user = result.context[:user]
      flash[:error] = result.context[:error]
      render :new
    end
  end

  private

  def registration_params
    params.require(:user)
          .permit( :name, :email, :password, :password_confirmation, :location_address, :location_address_two,
                   :location_city, :location_state, :location_zip, :birthday, :parent_name, :parent_email, :mentor,
                   :parent_location, :parent_location_two, :parent_city, :parent_state, :parent_zip, :parent_phone, :tos,
                   :stripe_token)
  end
end
