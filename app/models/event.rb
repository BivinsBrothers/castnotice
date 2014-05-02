class Event < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :region
  belongs_to :project_type

  has_many :event_unions
  has_many :unions, through: :event_unions
end
