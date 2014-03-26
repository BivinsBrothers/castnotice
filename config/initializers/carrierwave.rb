CarrierWave.configure do |config|
  credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  }
  fog_attributes = {'Cache-Control' => 'max-age=315576000, public'}
  fog_attributes['x-amz-storage-class'] = 'REDUCED_REDUNDANCY' unless Rails.env.production?

  if Rails.env.test?
    Fog.mock!
    connection = Fog::Storage.new(credentials)
    connection.directories.create(:key => ENV["AWS_S3_IMAGE_BUCKET"])

    config.enable_processing = false
  end
end