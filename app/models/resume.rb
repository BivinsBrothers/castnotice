class Resume < ActiveRecord::Base
  MAXIMUM_HEADSHOTS = 10
  MAXIMUM_VIDEOS = 8

  EYE_COLORS   = %w( brown hazel blue green silver amber )
  HAIR_COLORS  = %w( black brown blond auburn chestnut red gray )
  HAIR_LENGTHS = %w( short medium long )
  PIERCINGS    = %w( yes no )
  TATTOOS      = %w( yes no )
  CITIZENS     = %w( us_citizen resident_alien )
  AGENT_TYPES  = %w( theatrical television film commercial dance modeling_print modeling_high_fashion modeling_editorial modeling_commercial childrens_talent_agent)

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend FriendlyId
  friendly_id :slug_versions, use: :slugged

  serialize :unions

  belongs_to :user

  has_one :background_image, -> { where background: true }, class: Headshot, as: :imageable
  has_one :resume_photo, -> { where resume_photo: true }, class: Headshot, as: :imageable

  has_and_belongs_to_many :unions, join_table: :resume_unions
  has_and_belongs_to_many :accents, join_table: :resume_accents
  has_and_belongs_to_many :athletic_endeavors, join_table: :resume_athletic_endeavors
  has_and_belongs_to_many :ethnicities, join_table: :resume_ethnicities
  has_and_belongs_to_many :disabilities, join_table: :resume_disabilities
  has_and_belongs_to_many :fluent_languages, join_table: :resume_fluent_languages
  has_and_belongs_to_many :performance_skills, join_table: :resume_performance_skills
  has_and_belongs_to_many :disability_assistive_devices, join_table: :resume_disability_assistive_devices
  has_and_belongs_to_many :project_types, join_table: :resume_project_types
  has_and_belongs_to_many :regions, join_table: :resume_regions

  has_many :projects
  has_many :schools
  has_many :headshots, as: :imageable
  has_many :videos, as: :videoable

  validates :slug, uniqueness: true

  validates :eye_color, inclusion: { in: EYE_COLORS }, allow_nil: true
  validates :hair_color, inclusion: { in: HAIR_COLORS }, allow_nil: true
  validates :hair_length, inclusion: { in: HAIR_LENGTHS }, allow_nil: true
  validates :piercing, inclusion: { in: PIERCINGS }, allow_nil: true
  validates :tattoo, inclusion: { in: TATTOOS }, allow_nil: true
  validates :citizen, inclusion: { in: CITIZENS }, allow_nil: true
  validates :agent_type, inclusion: { in: AGENT_TYPES }, allow_nil: true

  def at_maximum_headshots?
    headshots.count >= MAXIMUM_HEADSHOTS
  end

  def at_maximum_videos?
    videos.count >= MAXIMUM_VIDEOS
  end

  def has_skill_attributes?
    associations = [:unions, :regions, :project_types, :performance_skills, :fluent_languages,
                    :ethnicities, :disability_assistive_devices, :disabilities,
                    :athletic_endeavors, :accents]
    associations.any?{|a| send(a).any? }
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
