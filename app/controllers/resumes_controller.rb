class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @resume_form = ResumeForm.new(current_user, current_resume.resume_form_attributes)
  end

  def update
    @resume_form = ResumeForm.new(current_user, resume_form_params)
    if @resume_form.save
      redirect_to :dashboard
    else
      render :edit
    end
  end

  private

  def resume_form_params
    params.require(:resume_form)
          .permit(:name, :email, :phone, :weight, :hair_color, :eye_color, :agent_name,
                  :agent_phone, :additional_skills, :height_feet, :height_inches, :birthday,
                  { unions: [] }, { schools_attributes: [:id, :education_type, :school, :major, :degree, :teacher, :years, :instruments] })
  end

  def current_resume
    current_user.resume || current_user.create_resume
  end
end
