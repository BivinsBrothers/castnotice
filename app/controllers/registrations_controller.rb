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
    user_params = registration_params
    user = User.new(user_params)

    begin
      customer = Stripe::Customer.create(card: user_params.stripe_token, description: user.id)
      user_params.merge({stripe_customer_id: customer.id})
      if user.save(user_params)
        user.create_resume
        #todo actually charge their card
        sign_in(user)
        redirect_to :dashboard
      else
        @user = user
        render :new
      end
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      @user = user
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
