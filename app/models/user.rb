class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 8

  has_one :background_image, -> { where background: true }, class_name: Headshot

  has_one :resume
  has_many :projects
  has_many :schools
  has_many :headshots
  has_many :videos

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true

  def at_maximum_headshots?
    headshots.count >= MAXIMUM_HEADSHOTS
  end

  def at_maximum_videos?
    videos.count >= MAXIMUM_VIDEOS
  end
end
