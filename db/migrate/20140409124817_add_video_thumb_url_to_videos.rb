class AddVideoThumbUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_thumb_url, :string
  end
end
