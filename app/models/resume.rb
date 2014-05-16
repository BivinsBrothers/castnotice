class Resume < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 8

  extend FriendlyId
  friendly_id :slug_versions, use: :slugged

  serialize :unions

  belongs_to :user

  has_one :background_image, -> { where background: true }, class_name: Headshot
  has_one :resume_photo, -> { where resume_photo: true }, class_name: Headshot

  has_many :resume_unions
  has_many :unions, through: :resume_unions
  has_many :projects
  has_many :schools
  has_many :headshots
  has_many :videos

  validates :slug, uniqueness: true

  def at_maximum_headshots?
    headshots.count >= MAXIMUM_HEADSHOTS
  end

  def at_maximum_videos?
    videos.count >= MAXIMUM_VIDEOS
  end

  def slug=(slug)
    if slug.empty?
      slug = nil
    else
      slug = slug.parameterize
    end

    super(slug)
  end

  private

  def slug_versions
    [
      proc { user.name },
      [proc { user.name }, :id]
    ]
  end
end
