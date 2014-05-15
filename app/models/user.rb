class User < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 8

  has_one :background_image, -> { where background: true }, class_name: Headshot
  has_one :resume_photo, -> { where resume_photo: true }, class_name: Headshot

  has_one :resume
  has_many :projects
  has_many :schools
  has_many :headshots
  has_many :videos

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :tos, acceptance: true, on: :create
  validates :name, :email, :birthday, presence: true
  validates :parent_name, :parent_email, :parent_location, :parent_city, :parent_state,
    :parent_zip, :parent_phone, presence: true, on: :create, if: :under_18?

  def at_maximum_headshots?
    headshots.count >= MAXIMUM_HEADSHOTS
  end

  def at_maximum_videos?
    videos.count >= MAXIMUM_VIDEOS
  end

  def happy_birthday?
    birthday.day == Date.current.day && birthday.month == Date.current.month
  end

  def under_18?
    birthday > 18.years.ago
  end
end
