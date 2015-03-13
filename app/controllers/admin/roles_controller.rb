module Admin
  class RolesController < ApplicationController
    before_action do
      @event = Event.find(params[:event_id])
    end

    def index
      @roles = @event.roles
    end

    def new
      @role = @event.roles.build
    end

    def create
      @role = @event.roles.build(role_params)

      if @role.save
        redirect_to admin_event_roles_path(@event), notice: "Successfully added role"
      else
        render :new
      end
    end

    def edit
      @role = @event.roles.find(params[:id])
    end

    def update
      @role = @event.roles.find(params[:id])

      if @role.update_attributes(role_params)
        redirect_to admin_event_roles_path(@event), notice: "Successfully updated role"
      else
        render :edit
      end
    end

    def destroy
      @role = @event.roles.find(params[:id])
      @role.destroy

      redirect_to admin_event_roles_path(@event), notice: "Successfully deleted role"
    end

    def show
      @role = @event.roles.find(params[:id])
    end

    private

    def role_params
      params.require(:role).permit(
        :description,
        :age_min,
        :age_max,
        :gender,
        :ethnicity,
        performance_skill_ids: []
      )
    end
  end
end
