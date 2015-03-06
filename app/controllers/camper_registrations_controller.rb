class CamperRegistrationsController < ApplicationController
  skip_before_action :enforce_promo_code_access

  before_action :ensure_no_previous_registration, only: :new
  before_action :ensure_order, only: :new
  before_action :ensure_camp, only: :new

  def new
    if order && order.camp
      @camper_registration = CamperRegistration.new(order_id: order.id, camp: order.camp)
      order.camper_count.times do
        @camper_registration.campers.build
      end
    else
      render text: "Unauthorized", status: 401
    end
  end

  def create
    @camper_registration = CamperRegistration.new(camper_registration_params)
    @camper_registration.set_missing_passwords
    if @camper_registration.save
      session[:registration_id] = @camper_registration.id
      @camper_registration.send_password_reset_emails!
      redirect_to camper_registration_path
    else
      render :new
    end
  end

  def show
    @camper_registration = CamperRegistration.find(session[:registration_id])
  end

  private

  def ensure_order
    unless order
      @message = "No order found."
      render :error
    end
    false
  end

  def ensure_camp
    unless order && order.camp
      @message = "Your order is complete! "
      @message << "Please join Castnotice to experience all of the benefits of membership."
      render :error
    end
    false
  end

  def ensure_no_previous_registration
    if CamperRegistration.find_by(order_id: params[:order_id])
      @message = "Congratulations! Your order has already been completed! Please contact support if you believe this to be an error."
      render :error
    end
    false
  end

  def order
    @order ||= LegacyOrder.find(params[:order_id]||params.fetch(:camper_registration, {})[:order_id])
  end
  helper_method :order

  def camper_registration_params
    params.require(:camper_registration).permit(
      :order_id,
      :camp_id,
      :how_heard,
      :referral_email,
      :referral_name,
      campers_attributes: [
        :gender,
        :school,
        :grade,
        :home_phone,
        :cell_phone,
        :emergency_contact_name,
        :emergency_contact_phone,
        :emergency_contact_relationship,
        :medical_history,
        :medical_allergies,
        :medical_current_medication,
        :shirt_size,
        :referred_by,
        :agreed_to_refund_policy,
        :agreed_to_medical_release,
        :photo_release,
        user_attributes: [
          :email,
          :name,
          :birthday,
          :location_address,
          :location_address_two,
          :location_city,
          :location_state,
          :location_zip,
          :parent_name,
          :parent_phone,
          :parent_email,
          :parent_location,
          :parent_location_two,
          :parent_city,
          :parent_state,
          :parent_zip,
          :tos
        ]
      ]
    )
  end
end
