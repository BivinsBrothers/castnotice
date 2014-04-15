class EventsController < ApplicationController
  def index
    @events = Event.all.order("audition_date ASC").limit(20)

    if current_user.present?
      meta = {member: true}
      meta[:admin] = current_user.admin?
      render json: @events, meta: meta
    else
      render json: @events, meta: {member: false, admin: false}, each_serializer: LimitedEventSerializer
    end
  end
end