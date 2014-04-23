class Headshot < ActiveRecord::Base
  validates :background, uniqueness: { scope: :user }, if: :background?
  validates_presence_of :image

  mount_uploader :image, HeadshotUploader

  belongs_to :user

  def set_as_background_image
    if user.background_image
      user.background_image.update_attributes(background: false)
    end

    self.background = true
    self.save
  end

  def remove_as_background_image
    if background?
      self.background = false
      self.save
    end
  end
end
