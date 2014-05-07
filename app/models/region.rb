class Region < ActiveRecord::Base
  include CategoryModelHelpers

  DEFAULTS = %w(Central Western Eastern Canada)

  validates :name, presence: true
end
