class CategoriesController < ApplicationController
  def index
    category_json = CategoryJson.new
    render json: category_json.generate
  end
end
