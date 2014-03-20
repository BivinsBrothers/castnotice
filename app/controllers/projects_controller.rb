class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)

    redirect_to dashboard_path
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def project_params
    params.require(:project).permit(:project_type, :title, :role, :director_studio)
  end
end