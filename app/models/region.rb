class Region < ActiveRecord::Base
  DEFAULTS = %w(Central Western Eastern Canada)

  validates :name, presence: true

  def self.for_select
    @select_options ||= Region.all.map { |r| [r.name, r.id] }
  end
end
