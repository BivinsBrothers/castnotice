class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location

  def new
    account_type = params[:account_type]
    if account_type == "mentor"
      render :mentor, locals: { resource: User.new }
    elsif Stripe::Plans.all.map { |plan| plan.id.to_s }.include?(account_type)
      @stripe_plan = account_type
      super
    else
      redirect_to root_path
    end
  end

  def create
    account_type = params[:account_type]
    if account_type == "mentor"
      result = CreateUser.perform( user_attributes: registration_params )
    else
      result = CreateUserAndStripeCustomer.perform(
        user_attributes: registration_params,
        stripe_token: params[:stripe_token],
        stripe_plan: params[:stripe_plan]
      )
    end
    
    if result.success?
      sign_in result.context[:user]
      redirect_to dashboard_path
    else
      flash[:error] = result.context[:error]
      @user = result.context[:user]
      if account_type == "mentor"
        render :mentor, locals: { resource: @user }
      else
        @stripe_plan = account_type
        render :new
      end
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
