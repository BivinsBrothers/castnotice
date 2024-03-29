class RegistrationsController < Devise::RegistrationsController
  skip_before_action :store_location

  def new
    @account_type = params[:account_type]
    if @account_type == "new_admin"
      @user = User.new
      render :admin, locals: { resource: @user }
    elsif @account_type == "mentor"
      @user = User.new
      @user.build_mentor_bio
      render :mentor, locals: { resource: @user }
    elsif Stripe::Plans.all.map { |plan| plan.id.to_s }.include?(@account_type)
      super
    else
      redirect_to root_path
    end
  end

  def create
    @account_type = params[:account_type]
    if @account_type == "mentor" || @account_type == "new_admin"
      result = CreateUser.call( user_attributes: registration_params )
    else
      result = CreateUserAndStripeCustomer.call(
        user_attributes: registration_params,
        stripe_token: params[:stripe_token],
        stripe_plan: @account_type
      )
    end

    if result.success?
      sign_in result.user
      redirect_to dashboard_path
    else
      flash[:failure] = result.error
      @user = result.user
      if @account_type == "new_admin"
        render :admin, locals: { resource: @user }
      elsif @account_type == "mentor"
        render :mentor, locals: { resource: @user }
      else
        render :new
      end
    end
  end

  private

  def registration_params
    params.require(:user)
          .permit( :name, :email, :password, :password_confirmation, :location_address, :location_address_two,
                   :location_city, :location_state, :location_zip, :birthday, :parent_name, :parent_email,
                   :parent_location, :parent_location_two, :parent_city, :parent_state, :parent_zip, :parent_phone,
                   :tos, :stripe_token, :admin, :mentor, :company, :company_address, :company_phone_number, :past_companies, :current_projects,
                   :teaching_experience, :talent_expertise, :dance_style, :education_experience, :artistic_organizations,
                   mentor_bio_attributes: [:company, :company_address, :company_phone, :past_company, :current_projects, :biography,
                                           :teaching_experience, :education_experience, :artistic_organizations, :hometown,
                                           :current_city, :associated_to_college, :college, :region_id ])
  end
end
