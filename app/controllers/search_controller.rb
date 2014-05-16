class SearchController < ApplicationController
  def index
    @resumes = Resume.search(params[:q]).records
    @search_term = params[:q]
  end
end
