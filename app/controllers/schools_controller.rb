class SchoolsController < ApplicationController
  before_action :store_location
  before_action :authenticate_user!

  def new
    @school = School.new
  end

  def create
    @school = current_resume.schools.build(school_params)
    if @school.save
      respond_to do |format|
        format.html { redirect_to edit_resume_path }
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:failure] = "Sorry unable to save your School please correct errors:
            #{@school.errors.full_message.to_sentence}"
          redirect_to edit_resume_path
        end
        format.js
      end
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
