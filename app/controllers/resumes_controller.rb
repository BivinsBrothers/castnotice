class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.resume.present?
      render :show
    else
      flash[:notice] = "Fill in the information you wish to appear on your resume."
      redirect_to edit_resume_path
    end
  end

  def edit
    @resume = current_user.resume || Resume.create(:user => current_user)
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

  private

  def resume_params
    params.require(:resume)
          .permit(:phone, :weight, :hair_color, :eye_color, :agent_name,
                  :agent_phone, :manager_name, :manager_phone, :additional_skills, :descriptive_tag, :height,
                  :gender, :hair_length, :piercing, :tattoo, :citizen,
                  :passport, { unions: [] })
  end
end
