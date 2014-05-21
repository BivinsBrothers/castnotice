class Event < ActiveRecord::Base
  AGE_MIN = 1
  AGE_MAX = 99

  scope :region, proc { |ids| where("region_id IN (?)", ids) }
  scope :project, proc { |ids| where("project_type_id IN (?)", ids) }
  scope :union, proc { |ids| joins(:event_unions).where("event_unions.union_id IN (?)", ids) }
  scope :age, proc { |age| where("age_range @> ?", age.to_i) }

  scope_accessible :region, :project, :union, :age

  validates :project_title, :region, :project_type, :gender, :unions, presence: true

  belongs_to :region
  belongs_to :project_type

  has_many :event_unions
  has_many :unions, through: :event_unions

  def age_min=(min)
    max = self.age_range ? self.age_range.end : AGE_MAX
    self.age_range = (min.to_i..max)
  end

  def age_max=(max)
    min = self.age_range ? self.age_range.begin : AGE_MIN
    self.age_range = (min..max.to_i)
  end

  def age_min
    self.age_range ? self.age_range.begin : AGE_MIN
  end

  def age_max
    self.age_range ? self.age_range.max : AGE_MAX
  end
end
