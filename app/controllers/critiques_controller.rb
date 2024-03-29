class CritiquesController < ApplicationController
  before_action :authenticate_user!

  before_action :able_to_create_critique?, only: [:new, :create]
  before_action :check_membership, only: [:new, :create]

  def new
    @critique = Critique.new
    @critique.videos.build
    2.times { @critique.headshots.build }
  end

  def create
    result = RequestCritique.call(
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
    @critique_response.videos.build

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
    @critiques = Critique.joins("LEFT JOIN critique_responses as cr ON critiques.id = cr.critique_id").order("cr.body DESC")
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
    critique_params = params.require(:critique).permit(:project_title, :notes, types: [], headshots_attributes: [:image],
                                     videos_attributes: [:video_url, :video])
    if critique_params[:video_attributes].present? && critique_params[:video_attributes][:video_url].present?
      critique_params[:video_attributes].delete(:video)
    end
    critique_params
  end

  def check_membership
    unless current_user.has_membership?
      flash[:notice] = 'CastNotice membership is required to request critiques'
      redirect_to new_membership_path(redirect_to: new_critique_path)
    end
  end
end
