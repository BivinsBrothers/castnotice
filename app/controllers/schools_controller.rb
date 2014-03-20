class SchoolsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @school = School.new
  end

  def create
    @school = current_user.schools.create(school_params)

    redirect_to dashboard_path
  end

  def edit
    @school = current_user.schools.find(params[:id])
  end

  def update
    @school = current_user.schools.find(params[:id])

    if @school.update_attributes(school_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def school_params
    params.require(:school).permit(:education_type, :school, :major, :degree, :teacher, :years, :instruments)
  end
end