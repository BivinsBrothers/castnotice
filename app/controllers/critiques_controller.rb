class CritiquesController < ApplicationController
  before_action :authenticate_user!

  before_action :able_to_create_critique?, only: [:new, :create]

  def new
    @critique = Critique.new
    @critique.videos.build
    2.times { @critique.headshots.build }
  end

  def create
    result = RequestCritique.perform(
      user: current_user,
      critique_attributes: critique_params
    )
    @critique = result.critique
    if result.success?
      flash[:success] = "Your critique request has been sent."
      redirect_to dashboard_path
    else
      flash[:failure] = result.error
      render :new
    end
  end

  def show
    @critique = Critique.find_by_uuid(params[:id])
    @critique_response = CritiqueResponse.new

    if able_to_view?(@critique)
      render :show
    else
      flash[:failure] = "You cannot view this page. Make sure you are logged in."
      redirect_to root_path
    end
  end

  def index
    unless current_user.mentor? || current_user.admin?
      redirect_to dashboard_path
    end
  end

  private

  def able_to_create_critique?
    if current_user.mentor? || current_user.admin?
      redirect_to dashboard_path
    end
  end

  def able_to_view?(critique)
    (current_user.admin? || (current_user.mentor? && @critique.open?) || current_user == critique.user)
  end

  def critique_params
    params.require(:critique).permit(:project_title, :notes, types: [], headshots_attributes: [:image],
                                     videos_attributes: [:video_url])
  end
end
