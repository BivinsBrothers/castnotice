class Event < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :region
  belongs_to :project_type
end
