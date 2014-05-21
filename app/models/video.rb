class Video < ActiveRecord::Base
  validate :validate_video_url_format

  before_save :set_video_thumb_url

  belongs_to :videoable, polymorphic: true

  def resume=(resume)
    self.videoable = resume
  end

  def critique=(critique)
    self.videoable = critique
  end

  def youtube_id
    parsed = URI.parse(video_url) rescue nil
    Rack::Utils.parse_query(parsed.query)['v'] if parsed && parsed.host && parsed.host.match(/\byoutube.com$/)
  end

  def vimeo_id
    parsed = URI.parse(video_url) rescue nil
    if parsed && parsed.host && parsed.host.match(/\bvimeo\.com$/) && ( m = parsed.path.match(/\d{6,}/) )
      m[0]
    end
  end

  def validate_video_url_format
    return if video_url.blank?
    unless youtube_id || vimeo_id
      errors.add :video_url, "Enter the URL of a YouTube or Vimeo video page"
    end
  end

  def set_video_thumb_url
    if video_url_changed? || (video_url && !video_thumb_url)
      self.video_thumb_url = nil
      self.video_thumb_url = if youtube_id
                               "https://img.youtube.com/vi/#{youtube_id}/0.jpg"
                             elsif vimeo_id
                               fetch_vimeo_thumbs
                             end
    end
  end

  def fetch_vimeo_thumbs
    vimeo_url = URI.parse("http://vimeo.com/api/v2/video/#{vimeo_id}.json")
    response = Net::HTTP.get_response(vimeo_url)
    parsed_response = JSON.parse(response.body)
    base_url = URI.parse(parsed_response.first['thumbnail_medium']).to_s rescue nil

    best_vimeo_thumb(base_url || '')
  end

  def best_vimeo_thumb(base_url)
    # Try different widths until one is readable.  The first three here are undocumented at Vimeo but are 16x9's; next two are 4x3's.
    [960, 1280, 295, 400, 200].each do |width|
      thumb_url = base_url.sub(/_[0-9]+\.jpg$/, "_#{width}.jpg")
      begin
        return thumb_url if Net::HTTP.get_response(URI.parse(thumb_url)).code.to_i < 300
      rescue Exception
      end
    end
    nil
  end
end
