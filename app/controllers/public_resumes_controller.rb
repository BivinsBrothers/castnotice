class PublicResumesController < ApplicationController
  def show
    @resume = Resume.friendly.find(params[:resume_slug])
    render "resumes/show"
  end
end
