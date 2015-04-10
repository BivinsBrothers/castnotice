class CritiqueResponsesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_critique
  before_action :check_if_critique_closed, only: :create

  def create
    @critique_response = @critique.build_response(critique_response_params.merge(user_id: current_user.id))
    if @critique_response.save
      Notifier.critique_response(@critique).deliver
      Notifier.critique_complete(@critique).deliver
      flash[:success] = "Your response has been sent."
      redirect_to critiques_path
    else
      flash[:failure] = "Please try to send your response again."
      redirect_to critique_path(@critique)
    end
  end

  private

  def set_critique
    @critique = Critique.find_by_uuid(params[:critique_id])
  end

  def check_if_critique_closed
    if @critique.closed? && current_user.mentor?
      redirect_to critiques_path
    end
  end

  def critique_response_params
    params.require(:critique_response).permit(:body, :headshot_comment, :overall_comment, :improvement_comment, :resume_comment, videos_attributes: [:video])
  end
end
