class CategoriesController < ApplicationController
  skip_before_action :store_location

  def index
    category_json = CategoryJson.new
    render json: category_json.generate
  end
end
