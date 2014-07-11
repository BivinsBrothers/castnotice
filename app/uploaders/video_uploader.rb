class VideoUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  Rails.application.routes.default_url_options = ActionMailer::Base.default_url_options

  after :store, :send_to_zencoder

  def fog_public
    false
  end

  def fog_authenticated_url_expiration
    1.hour
  end

  def store_dir
    stored_file_path("original")
  end

  def default_url
    ActionController::Base.helpers.asset_path("sample-still.jpg")
  end

  version :mp4 do
    def full_filename(for_file)
      filename_with_ext("mp4")
    end

    def store_dir
      stored_file_path("processed")
    end
  end

  version :webm do
    def full_filename(for_file)
      filename_with_ext("webm")
    end

    def store_dir
      "videos/#{model.id}/#{model.id}/processed"
    end
  end

  version :thumb do
    def full_filename(for_file)
      "thumbnail.png"
    end

    def store_dir
      stored_file_path("thumbnail")
    end
  end

  def extension_white_list
    %w(mov avi mp4 kmv wmv mpg m2v m4v 3g2 3gp)
  end

  protected

  def send_to_zencoder(args)
    # CarrierWave will try to call this for each version, we only
    # want to send a zencoder job for original
    return if version_name
    # This prevents the encoding from happening in dev/test environments
    return if storage.is_a?(CarrierWave::Storage::File)

    bucket = VideoUploader.fog_directory

    response = Zencoder::Job.create({
      input: url,
      notifications: [
        # For local development, use this notification url
        # Run "zencoder_fetcher -u http://localhost:3000/video_statuses [api key]" to
        # query Zencoder for finished jobs to post to your local server
        "http://zencoderfetcher/"
        # Rails.application.routes.url_helpers.video_statuses_url
      ],
      output: [
        {
          url: "s3://#{bucket}/#{processed_path("webm")}",
        },
        {
          url: "s3://#{bucket}/#{processed_path("mp4")}"
        },
        {
          thumbnails: {
            times: [2],
            base_url: "s3://#{bucket}/#{File.dirname(model.video.thumb.path)}",
            filename: "thumbnail"
          }
        }
      ]
    })

    if response.success?
      model.update_attributes(
        video_job_id:     response.body["id"],
        video_job_status: "processing"
      )
    else
      raise "Unable to request videos from zencoder: #{response.body.inspect}"
    end
  end

  def processed_path(extension)
    "#{stored_file_path("processed")}/#{filename_with_ext(extension)}"
  end

  def filename_with_ext(ext)
    base_filename = File.basename(model.video_name, File.extname(model.video_name))
    "#{base_filename}.#{ext}"
  end

  def stored_file_path(file_type)
    "videos/#{model.id}/#{model.id}/#{file_type}"
  end
end
