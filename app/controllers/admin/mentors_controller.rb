class Admin::MentorsController < ApplicationController

  def index
    @mentors = User.talent_mentors
  end
end
