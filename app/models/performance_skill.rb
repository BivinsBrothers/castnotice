class PerformanceSkill < ActiveRecord::Base
  include CategoryModelHelpers

  validates :name, presence: true

  default_scope -> { order(:name) }
end
