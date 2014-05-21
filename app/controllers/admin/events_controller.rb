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
      :project_title, :project_type_id, :region_id, :gender, :special_notes, :age_max, :age_min,
      :storyline, :character_description, :how_to_audition, :audition_date, :start_date,
      :additional_project_info, :project_type_details, :location, :casting_director, :paid, union_ids: []
    )
  end
end
