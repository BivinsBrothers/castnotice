class Admin::EventsController < ApplicationController
  before_action :enforce_admin

  def new
    @event = Event.new
  end

  def create
    if @event = Event.create(event_params)
      redirect_to page_path("calendar")
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      redirect_to page_path("calendar")
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to page_path("calendar")
  end

  private

  def enforce_admin
    current_user.admin?
  end

  def event_params
    params.require(:event).permit(
      :name, :project_type_id, :region_id, :performer_type, :character, :pay,
      :director, :story, :description, :audition, :audition_date, :start_date, :end_date,
      :location, :casting_director, :writers, :producers, :paid, union_ids: []
    )
  end
end
