class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @resume_form = ResumeForm.new(current_user)
  end

  def create
    resume_form = ResumeForm.new(current_user, resume_form_params)

    if resume_form.save
      redirect_to :dashboard
    else
      @resume_form = resume_form
      render :new
    end
  end

  def edit
    @resume_form = ResumeForm.new(current_user)
  end

  def update
    resume_form = ResumeForm.new(current_user, resume_form_params)

    if resume_form.save
      redirect_to :dashboard
    else
      @resume_form = resume_form
      render :edit
    end
  end

  private

  def resume_form_params
    params.require(:resume_form)
          .permit(:name, :email, :phone, :weight, :hair_color, :eye_color, :agent_name,
                  :agent_phone, :additional_skills, :height_feet, :height_inches, :birthday,
                  { unions: [] })
  end

  def current_resume
    @resume ||= current_user.resume
  end
end