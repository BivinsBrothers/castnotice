class PublicResumesController < ApplicationController
  skip_before_action :store_location

  def show
    @resume = Resume.friendly.find(params[:resume_slug])
    render "resumes/show"
  end

  def print
    @resume = Resume.friendly.find(params[:resume_slug])
    render "resumes/print", layout: "print"
  end
end
