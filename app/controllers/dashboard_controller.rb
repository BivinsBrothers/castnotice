class DashboardController < ApplicationController
  before_action :store_location
  before_action :authenticate_user!

  def show
  end
end
