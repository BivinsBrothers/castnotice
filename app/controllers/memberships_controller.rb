class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = CreateStripeMembership.call(
      user: current_user,
      stripe_token: params[:stripe_token],
      stripe_plan: params[:account_type]
    )

    if result.success?
      redirect_to (params[:redirect_to].presence || root_path)
    else
      flash.now[:failure] = result.error
      render :new
    end
  end
end
