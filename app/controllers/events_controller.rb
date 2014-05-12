class EventsController < ApplicationController
  def index
    events = Event.where(audition_date: query_date_range)
                  .order("audition_date ASC")
                  .periscope(event_params.fetch(:filters, {}))

    if current_user.present?
      render json: events, meta: {member: true, admin: current_user.admin?}
    else
      render json: events, meta: {member: false, admin: false}, each_serializer: LimitedEventSerializer
    end
  end

  private

  def query_date_range
    params[:date] ||= {}
    start_date = DateTime.parse(params[:date].fetch(:start, Time.now.in_time_zone("UTC").beginning_of_month.to_s))
    end_date = DateTime.parse(params[:date].fetch(:end, Time.now.in_time_zone("UTC").end_of_month.to_s))

    range_for(start_date, end_date)
  end

  def range_for(start_date, end_date)
    if end_date < 60.days.ago
      nil
    elsif start_date < 60.days.ago && end_date > 60.days.ago
      60.days.ago..end_date
    else
      start_date..end_date
    end
  end

  def event_params
    params.permit(date: [:start, :end], filters: [union: [], project: [], region: []])
  end
end
