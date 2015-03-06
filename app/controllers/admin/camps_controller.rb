class Admin::CampsController < ApplicationController
  before_action :ensure_admin
  before_action :find_camp, only: [:edit, :update]

  def index
    @camps = Camp.all
    incomplete = IncompleteOrder.all(CamperRegistration.pluck(:order_id))
    @unregistered = incomplete ? incomplete.group_by(&:code) : {}
  end

  def show
    @camp = Camp.find(params[:id])
    respond_to do |format|
      format.csv { render text: @camp.to_csv }
    end
  end

  def create
    camp.attributes = camp_params
    if camp.save
      redirect_to admin_camps_path
    else
      render :new
    end
  end
  alias update create

  private

  def find_camp
    @camp = Camp.find(params[:id])
  end

  def camp
    @camp ||= Camp.new
  end
  helper_method :camp

  def camp_params
    params.require(:camp).permit!
  end
end
