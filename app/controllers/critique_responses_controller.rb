class CritiqueResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @critique = Critique.find_by_uuid(params[:critique_id])
    @critique_response = @critique.build_response(critique_response_params.merge(user_id: current_user.id))
    if @critique_response.save
      Notifier.critique_response(@critique).deliver
      flash[:success] = "Your response has been sent."
      redirect_to dashboard_path
    else
      flash[:failure] = "Please try to send your response again."
      render critique_path
    end
  end

  private

  def critique_response_params
    params.require(:critique_response).permit(:body, :user_id, :critique_id)
  end
end
