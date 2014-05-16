class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_resume.projects.build(project_params)
    if @project.save
      respond_to do |format|
        format.html { redirect_to edit_resume_path }
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:failure] = "Sorry unable to save your Project please correct errors:
            #{@project.errors.full_message.to_sentence}"
          redirect_to edit_resume_path
        end
        format.js
      end
    end
  end

  def edit
    @project = current_resume.projects.find(params[:id])
  end

  def update
    @project = current_resume.projects.find(params[:id])

    if @project.update_attributes(project_params)
      flash[:success] = "Your project saved."
      redirect_to edit_resume_path
    else
      flash[:failure] = "Sorry unable to save your Project please try again."
    end
  end

  def destroy
    current_resume.projects.find(params[:id]).destroy
    redirect_to edit_resume_path
  end

  def project_params
    params.require(:project).permit(:project_type_id, :title, :role, :director_studio)
  end
end
