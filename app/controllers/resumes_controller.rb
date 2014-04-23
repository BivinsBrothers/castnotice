class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.resume.present?
      render :show
    else
      flash[:notice] = "Fill in the information you wish to appear on your resume."
      redirect_to new_resume_path
    end
  end

  def new
    @resume = Resume.new
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new


    if @resume.save
      redirect_to edit_resume_path
    else
      render :new
    end
  end

  def edit
    @resume = current_user.resume
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new
  end

  def update
    @resume = current_user.resume
    @project = Project.new
    @school = School.new
    @headshot = Headshot.new

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
                  :agent_phone, :additional_skills, :descriptive_tag, :height,
                  :gender, :hair_length, :piercing, :tattoo, :nudity, :citizen,
                  :passport, { unions: [] })
  end
end