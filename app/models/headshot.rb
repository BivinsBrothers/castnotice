class Headshot < ActiveRecord::Base
  before_destroy :remove_background_image

  mount_uploader :image, HeadshotUploader

  belongs_to :user

  def current_background?
    user.background_image == self
  end

  private

  def remove_background_image
    user.update_attributes(background_image: nil) if current_background?
  end
end
