class Region < ActiveRecord::Base
  DEFAULTS = %w(Central Western Eastern Canada)

  validates :name, presence: true
end
