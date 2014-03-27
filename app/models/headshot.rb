class Headshot < ActiveRecord::Base
  validates :is_background, uniqueness: { scope: :user }, if: :is_background

  mount_uploader :image, HeadshotUploader

  belongs_to :user

  def set_as_background_image
    if user.background_image
      user.background_image.update_attributes(is_background: false)
    end

    self.is_background = true
    self.save
  end

  def remove_as_background_image
    if is_background?
      self.is_background = false
      self.save
    end
  end
end
