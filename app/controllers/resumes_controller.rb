class ResumesController < ApplicationController
  before_filter :authenticate_user!


  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user = current_user

    if @resume.save
      redirect_to resume_path
    else
      render :new
    end
  end

  def edit
    @resume = current_user.resume
  end

  def update
    @resume = current_user.resume
    if @resume.update_attributes(resume_params)
      redirect_to resume_path
    else
      render :edit
    end
  end

  private

  def resume_params
    params.require(:resume)
          .permit(:phone, :weight, :hair_color, :eye_color, :agent_name,
                  :agent_phone, :additional_skills, :descriptive_tag, :height, { unions: [] })
  end
end