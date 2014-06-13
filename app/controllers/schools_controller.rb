class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def new
    @school = School.new
  end

  def create
    @school = current_resume.schools.build(school_params)
    if @school.save
      redirect_to edit_resume_path
    else
      flash[:failure] = "Sorry unable to save your School please correct errors:
        #{@school.errors.full_message.to_sentence}"
      redirect_to edit_resume_path
    end
  end

  def edit
    @school = current_resume.schools.find(params[:id])
  end

  def update
    @school = current_resume.schools.find(params[:id])

    if @school.update_attributes(school_params)
      flash[:success] = "Your school has been saved."
      redirect_to edit_resume_path
    else
      render :edit
    end
  end

  def destroy
    current_resume.schools.find(params[:id]).destroy
    redirect_to edit_resume_path
  end

  def school_params
    params.require(:school).permit(:education_type, :school, :major, :degree, :teacher, :years, :instruments)
  end
end
