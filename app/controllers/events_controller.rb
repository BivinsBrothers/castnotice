class EventsController < ApplicationController
  def index
    @events = Event.all.order("audition_date ASC").limit(20)

    meta = {}
    meta[:member] = current_user.present?

    if current_user.present?
      meta[:admin] = current_user.admin
    else
      meta[:admin] = false
    end

    render json: @events, meta: meta
  end
end