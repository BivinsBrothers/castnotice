class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.resume.present?
      @resume = current_user.resume
      render :show
    else
      flash[:notice] = "Fill in the information you wish to appear on your resume."
      redirect_to edit_resume_path
    end
  end

  def edit
    @resume = current_user.resume || current_user.create_resume
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new
    @video = Video.new
  end

  def update
    @resume = current_user.resume

    if @resume.update_attributes(resume_params)
      redirect_to edit_resume_path
    else
      render :edit
    end
  end

  def print
    @resume = current_user.resume || current_user.create_resume
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
