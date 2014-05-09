class EventsController < ApplicationController
  def index
    interactor = Events::Fetch.perform(date: event_params[:date])

    if current_user.present?
      render json: interactor.events, meta: {member: true, admin: current_user.admin?}
    else
      render json: interactor.events, meta: {member: false, admin: false}, each_serializer: LimitedEventSerializer
    end
  end

  def event_params
    params.permit(date: [:start, :end])
  end
end
