class CritiquesController < ApplicationController
  before_action :authenticate_user!


  def new
    @critique = Critique.new
    @critique.videos.build
    2.times { @critique.headshots.build }
  end

  def create
    @critique = current_user.critiques.build(critique_params)

    if @critique.save
      Notifier.critique_request(@critique).deliver
      flash[:success] = "Your critique request has been sent."
      redirect_to dashboard_path
    else
      flash[:failure] = "Your critique failed to send please try again."
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

  private

  def able_to_view?(critique)
    current_user.admin? || current_user.mentor? || current_user == critique.user
  end

  def critique_params
    params.require(:critique).permit(:project_title, :notes, headshots_attributes: [:image],
                                     videos_attributes: [:video_url])
  end
end
