class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @resume = current_resume
    render :show
  end

  def edit
    @resume = current_resume
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new
    @video = Video.new
  end

  def update
    @resume = current_resume

    if @resume.update_attributes(resume_params)
      redirect_to edit_resume_path
    else
      render :edit
    end
  end

  def print
    @resume = current_resume
    render "print", layout: "print"
  end

  private

  def resume_params
    params.require(:resume)
          .permit(:phone, :phone_two, :weight, :hair_color, :eye_color, :agent_name, :slug,
                  :agent_phone, :agent_email, :agent_location, :agent_location_two, :agent_city, :agent_state, :agent_zip,
                  :agent_type, :manager_name, :manager_phone, :additional_skills, :descriptive_tag, :height,
                  :gender, :hair_length, :piercing, :tattoo, :citizen,
                  :passport, union_ids: [])
  end
end
