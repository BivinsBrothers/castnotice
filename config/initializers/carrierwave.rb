CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     Figaro.env.aws_access_key_id,
        aws_secret_access_key: Figaro.env.aws_secret_access_key,
        region:                Figaro.env.aws_s3_region
    }

    config.fog_attributes['Cache-Control']       = 'max-age=315576000, public'

    # config.fog_public = false
    # config.fog_authenticated_url_expiration = 1.hour
  end
end