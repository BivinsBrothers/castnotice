class Role < ActiveRecord::Base
  AGE_MIN = 1
  AGE_MAX = 99

  belongs_to :event
  has_many :role_performance_skills
  has_many :performance_skills, through: :role_performance_skills
  validate :range_for_age

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
    self.age_range ? self.age_range.begin : nil
  end

  def age_max
    self.age_range ? self.age_range.max : nil
  end

  def range_for_age
    if age_min.to_i > age_max.to_i
      errors.add(:base, "minimum age is cannot be greater than maximum age")
    end
  end
end
