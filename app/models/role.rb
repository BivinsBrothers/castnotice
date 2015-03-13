class Role < ActiveRecord::Base
  AGE_MIN = 1
  AGE_MAX = 99

  belongs_to :event
  has_and_belongs_to_many :performance_skills, join_table: :role_performance_skills

  scope :age, proc { |age| where("age_range @> ?", age.to_i) }

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
