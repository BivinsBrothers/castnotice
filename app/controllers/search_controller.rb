class SearchController < ApplicationController
  def index
    @resumes = Resume.search(params[:q]).records
  end
end
