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

    def edit
      @roll = @event.rolls.find(params[:id])
    end

    def update
      @roll = @event.rolls.find(params[:id])

      if @roll.update_attributes(roll_params)
        redirect_to admin_event_rolls_path(@event), notice: "Successfully updated roll"
      else
        render :edit
      end
    end

    def destroy
      @roll = @event.rolls.find(params[:id])
      @roll.destroy

      redirect_to admin_event_rolls_path(@event), notice: "Successfully deleted roll"
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
