module Admin
  class RollsController < ApplicationController
    before_action do
      @event = Event.find(params[:event_id])
    end

    def index
      @rolls = @event.rolls
    end
  end
end
