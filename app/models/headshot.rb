class Headshot < ActiveRecord::Base
  validates :background, uniqueness: { scope: :imageable }, if: :background?
  validates_presence_of :image

  mount_uploader :image, HeadshotUploader

  belongs_to :imageable, polymorphic: true

  def resume=(resume)
    self.imageable = resume
  end

  def critique=(critique)
    self.imageable = critique
  end

  def set_as_background_image
    if imageable.background_image
      imageable.background_image.update_attributes(background: false)
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

  def set_as_resume_photo
    if imageable.resume_photo
      imageable.resume_photo.update_attributes(resume_photo: false)
    end

    self.resume_photo = true
    self.save
  end

  def remove_as_resume_photo
    if resume_photo?
      self.resume_photo = false
      self.save
    end
  end
end
