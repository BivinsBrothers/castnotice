class Event < ActiveRecord::Base
  scope :region, proc { |ids| where("region_id IN (?)", ids) }
  scope :project, proc { |ids| where("project_type_id IN (?)", ids) }
  scope :union, proc { |ids| joins(:event_unions).where("event_unions.union_id IN (?)", ids) }
  scope :performance_skill, proc { |ids|
    joins(:role_performance_skills).where("role_performance_skills.performance_skill_id IN (?)", ids)
  }

  scope_accessible :region, :project, :union, :performance_skill

  validates :project_title, :region, :project_type, :unions,
  :production_location, :pay_rate, :staff, :location,
  :how_to_audition, presence: true

  belongs_to :region
  belongs_to :project_type

  has_many :event_unions
  has_many :unions, through: :event_unions
  has_many :roles
  has_many :event_audition_dates
  has_many :role_performance_skills, through: :roles

  accepts_nested_attributes_for :event_audition_dates, allow_destroy: true
end
