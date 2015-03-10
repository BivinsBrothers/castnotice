class Admin::EventsController < ApplicationController
  before_action :enforce_event_manage_permissions

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to page_path("calendar")
    else
      flash[:failure] = "Your event failed to save. Please try again."
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

  def enforce_event_manage_permissions
    current_user.admin? || current_user.mentor?
  end

  def event_params
    params.require(:event).permit(
      :project_title, :project_type_id, :region_id, :special_notes,
      :storyline, :how_to_audition, :audition_date, :location,
      :casting_director, :paid, :stipend, :staff, :pay_rate, :audition_times, :production_location, union_ids: []
    )
  end
end
