class EventsController < ApplicationController
  def index
    if event_params[:date]
      start_date = DateTime.parse(event_params[:date][:start])
      end_date = DateTime.parse(event_params[:date][:end])
    else
      start_date = DateTime.now.in_time_zone("UTC").beginning_of_month
      end_date = DateTime.now.in_time_zone("UTC").end_of_month
    end

    @events = Event.where(audition_date: (start_date..end_date)).order("audition_date ASC")

    if current_user.present?
      meta = {member: true}
      meta[:admin] = current_user.admin?
      render json: @events, meta: meta
    else
      render json: @events, meta: {member: false, admin: false}, each_serializer: LimitedEventSerializer
    end
  end

  def event_params
    params.permit(date: [:start, :end])
  end
end