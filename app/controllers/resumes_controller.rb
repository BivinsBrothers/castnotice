class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @resume_form = ResumeForm.new(user: current_user)
  end

  def create
    form_params = resume_params

    form_params.merge!(user: current_user)
    form_params.merge!(birthday: Date.civil(
      form_params.delete("birthday(1i)").to_i,
      form_params.delete("birthday(2i)").to_i,
      form_params.delete("birthday(3i)").to_i
    ))

    resume_form = ResumeForm.new(form_params)

    if resume_form.save
      redirect_to :dashboard
    else
      @resume_form = resume_form
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume_form)
          .permit(:name, :email, :phone, :weight, :hair_color, :eye_color, :agent_name,
                  :agent_phone, :additional_skills, :height_feet, :height_inches, :birthday,
                  { unions: [] })
  end
end