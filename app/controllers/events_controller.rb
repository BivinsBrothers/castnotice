class EventsController < ApplicationController
  skip_before_action :store_location
  skip_before_action :enforce_promo_code_access

  def index
    events = Event.joins(:event_audition_dates).where(event_audition_dates: {audition_date: query_date_range})
      .select('events.* as event, event_audition_dates.audition_date as audition_date')
      .order("event_audition_dates.audition_date ASC")
      .periscope(event_params.fetch(:filters, {}))

    if current_user.present?
      render json: events, meta: {member: true, admin: current_user.admin? || current_user.mentor?}
    else
      render json: events, meta: {member: false, admin: false}, each_serializer: LimitedEventSerializer
    end
  end

  private

  def query_date_range
    params[:date] ||= {}
    start_date = DateTime.parse(params[:date].fetch(:start, Time.now.in_time_zone("UTC").beginning_of_month.to_s))
    end_date = DateTime.parse(params[:date].fetch(:end, Time.now.in_time_zone("UTC").end_of_month.to_s))

    range_for(start_date, end_date.end_of_day)
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
    params.permit(date: [:start, :end], filters: [:age, union: [], project: [], region: [], performance_skill: []])
  end
end
