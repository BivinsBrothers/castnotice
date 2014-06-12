class CategoriesController < ApplicationController
  skip_before_action :store_location
  skip_before_action :enforce_promo_code_access

  def index
    category_json = CategoryJson.new
    render json: category_json.generate
  end
end
