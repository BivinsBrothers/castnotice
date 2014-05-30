class SearchController < ApplicationController
  skip_before_action :store_location

  def index
    @resumes = Resume.search(params[:q]).records
  end
end
