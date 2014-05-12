class Event < ActiveRecord::Base
  scope :region, proc { |ids| where("region_id IN (?)", ids) }
  scope :project, proc { |ids| where("project_type_id IN (?)", ids) }
  scope :union, proc { |ids| joins(:event_unions).where("event_unions.union_id IN (?)", ids) }

  scope_accessible :region, :project, :union

  validates :name, presence: true

  belongs_to :region
  belongs_to :project_type

  has_many :event_unions
  has_many :unions, through: :event_unions
end
