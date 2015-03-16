class RolePerformanceSkill < ActiveRecord::Base
  belongs_to :role
  belongs_to :performance_skill
end
