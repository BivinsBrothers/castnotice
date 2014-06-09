class Resume < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 8

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend FriendlyId
  friendly_id :slug_versions, use: :slugged

  serialize :unions

  belongs_to :user

  has_one :background_image, -> { where background: true }, class: Headshot, as: :imageable
  has_one :resume_photo, -> { where resume_photo: true }, class: Headshot, as: :imageable

  has_many :resume_unions
  has_many :resume_accents
  has_many :resume_athletic_endeavors
  has_many :resume_disabilities
  has_many :resume_disability_assistive_devices
  has_many :resume_ethnicities
  has_many :resume_fluent_languages
  has_many :resume_performance_skills
  has_many :accents, through: :resume_accents
  has_many :athletic_endeavors, through: :resume_athletic_endeavors
  has_many :disabilities, through: :resume_disabilities
  has_many :disability_assistive_devices, through: :resume_disability_assistive_devices
  has_many :ethnicities, through: :resume_ethnicities
  has_many :fluent_languages, through: :resume_fluent_languages
  has_many :performance_skills, through: :resume_performance_skills
  has_many :project_types, through: :resume_project_types
  has_many :regions, through: :resume_regions
  has_many :unions, through: :resume_unions
  has_many :projects
  has_many :schools
  has_many :headshots, as: :imageable
  has_many :videos, as: :videoable

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

  def as_indexed_json(options={})
    self.as_json(
      include: { unions: { only: :name },
                 projects: { only: :title },
                 schools: { only: :school },
                 user:   {  only: :name }
    })
  end

  private

  def slug_versions
    [
      proc { user.name },
      [proc { user.name }, :id]
    ]
  end
end
