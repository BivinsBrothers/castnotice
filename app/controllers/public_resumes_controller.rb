class PublicResumesController < ApplicationController
  def show
    @resume = Resume.friendly.find(params[:resume_slug])
    render "resumes/show"
  end

  def print
    @resume = Resume.friendly.find(params[:resume_slug])
    render "resumes/print", layout: "print"
  end
end
