class HeadshotUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumb do
    process :auto_orient
    process :resize_to_fill => [200, 150]
  end

  version :background do
    process :auto_orient
    process :resize_to_fill => [1920, 1080]
  end

  version :resume_print do
    process :auto_orient
    process :resize_to_fill => [250, 300]
  end

  version :profile_photo do
    process :auto_orient
    process :resize_to_fill => [250, 300]
  end

  version :search_thumb do
    process :auto_orient
    process :resize_to_fill => [300, 300]
  end

  def auto_orient
    manipulate! do |img|
      img.auto_orient
      img
    end
  end
end
