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
    @event.update_attributes!(event_params)

    if @event.save
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
      :name, :project_type, :region, :performer_type, :character, :pay, :union, :paid,
      :director, :story, :description, :audition, :audition_date, :start_date, :end_date
    )
  end
end