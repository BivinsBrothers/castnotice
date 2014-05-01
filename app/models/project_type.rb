class ProjectType < ActiveRecord::Base
  validates :name, presence: true

  def self.for_select
    @select_options ||= ProjectType.all.map { |r| [r.name, r.id] }
  end
end
