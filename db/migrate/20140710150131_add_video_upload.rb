class AddVideoUpload < ActiveRecord::Migration
  def change
    add_column :videos, :video, :string
    add_column :videos, :video_job_id, :integer
    add_column :videos, :video_job_status, :string
    add_column :videos, :video_width, :integer
    add_column :videos, :video_height, :integer
    add_column :videos, :video_tmp, :string
  end
end
