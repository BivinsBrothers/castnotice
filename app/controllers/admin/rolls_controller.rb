module Admin
  class RollsController < ApplicationController
    before_action do
      @event = Event.find(params[:event_id])
    end

    def index
      @rolls = @event.rolls
    end

    def new
      @roll = @event.rolls.build
    end

    def create
      @roll = @event.rolls.build(roll_params)

      if @roll.save
        redirect_to admin_event_rolls_path(@event), notice: "Successfully added roll"
      else
        render :new
      end
    end

    private

    def roll_params
      params.require(:roll).permit(
        :description,
        :age_min,
        :age_max,
        :gender,
        :ethnicity
      )
    end
  end
end
