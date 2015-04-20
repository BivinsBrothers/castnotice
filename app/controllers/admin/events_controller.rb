class Admin::EventsController < ApplicationController
  before_action :enforce_event_manage_permissions

  def new
    @event = current_user.events.build
    @event.event_audition_dates.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to page_path("calendar")
    else
      flash[:failure] = "Your event failed to save. Please try again."
      render :new
    end
  end

  def edit
    unless event
      redirect_to page_path("calendar")
    end
  end

  def update
    if event.update_attributes(event_params)
      redirect_to page_path("calendar")
    else
      render :edit
    end
  end

  def destroy
    event.destroy if event
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
      :start_date, :end_date, :casting_director, :paid, :stipend,
      :staff, :pay_rate, :audition_times, :production_location,
      :user_id, union_ids: [],
      event_audition_dates_attributes: [:audition_date, :_destroy, :id]
    )
  end

  def event
    @event ||= Event.find(params[:id])
    unless current_user == @event.user || current_user.superadmin?
      flash[:notice] = "You are not allowed to edit this event."
      @event = nil
    else
      @event
    end
  end
end
