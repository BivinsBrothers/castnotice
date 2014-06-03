class MentorsController < Devise::RegistrationsController
  skip_before_action :store_location

  def mentor_sign_up
    render 'registrations/mentor'
  end

end